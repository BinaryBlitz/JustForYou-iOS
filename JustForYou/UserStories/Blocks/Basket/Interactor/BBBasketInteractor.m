#import "BBBasketInteractor.h"

#import "BBBasketInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"
#import "BBCalendarService.h"

@implementation BBBasketInteractor

#pragma mark - Методы BBBasketInteractorInput

typedef void (^ArrayCompletion)(NSArray *purchases);
typedef void (^DeliveryCompletion)();

- (void)updateUserAndShowCurrentBonuses {
  [[BBServerService sharedService] showUserWithUserToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BBUser *user, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        BBUser *oldUser = [[BBUserService sharedService] currentUser];
        oldUser.balance = user.balance;
        [[BBUserService sharedService] saveCurrentUser:oldUser];
        [self.output bonusesUpdate];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

- (void)currentOrdersInBasket {
  BBUser *user = [[BBUserService sharedService] currentUser];
  [self.output currentOrders:user.ordersProgramArray];
}

- (void)createOrderOnServerWithTypePayment:(BBTypePayment)type payCard:(BBPayCard *)card useBonuses:(BOOL)use {
  BBUser *user = [[BBUserService sharedService] currentUser];
  __block NSInteger cardId = 0;
  HQDispatchToMainQueue(^{
    cardId = card.payCardId;
  });
  NSArray* orders = user.ordersProgramArray;
  [[BBServerService sharedService] createOrderWithOrders:orders
                                                apiToken:[[BBUserService sharedService] tokenUser]
                                             numberPhone:user.numberPhone
                                              useBonuses:use
                                              completion:^(BBServerResponse *response, NSInteger orderId, NSError *error) {
                                                if (response.kConnectionServer == kSuccessfullyConnection) {
                                                  if (response.responseCode == 201) {
                                                    if (type == kTypeNewPayment) {
                                                      [[BBServerService sharedService] createPaymentsWithOrderId:orderId apiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BBPayment *payment, NSError *error) {
                                                        if (payment) {
                                                          [self.output paymentDidStartWithPayment:payment];
                                                        }
                                                      }];
                                                    } else {
                                                      [[BBServerService sharedService] createPaymentsWithPayCard:cardId orderId:orderId apiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BOOL paid, NSError *error) {
                                                        if (paid) {
                                                          [self createDeliveriesFromOrders:orders];
                                                        } else {
                                                          [self.output paymentError];
                                                        }
                                                      }];
                                                    }
                                                  } else {
                                                    [self.output errorServer];
                                                  }
                                                } else {
                                                  [self.output errorNetwork];
                                                }
                                              }];
}

- (void)createDeliveriesFromOrders:(NSArray *)ordersProgramArray {
  [self listPurchasesUserWithCompletion:^(NSArray *purchases) {

    NSArray * filteredPurchases = [purchases filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
      BBPurchases* purchase = evaluatedObject;
      for (BBOrderProgram * program in ordersProgramArray) {
        if (program.programId == purchase.programId) {
          return true;
        }
      }
      return false;
    }]];

    __block NSInteger ordersFinished = 0;
    [filteredPurchases enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      BBPurchases* purchase = obj;
      BBOrderProgram* orderProgram = [ordersProgramArray objectAtIndex:idx];
      [self createDeliveryOnServerWithProgram:orderProgram purchase:purchase completion:^{
        ordersFinished += 1;
        if (ordersFinished == ordersProgramArray.count) {
          NSArray* orders = BBUserService.sharedService.currentUser.ordersProgramArray;
          if (orders.count == 0) {
            [self.output paymentSuccessfull];
          } else {
            [self.output paymentError];
          }
        }
      }];
    }];
  }];
}

- (void)listPurchasesUserWithCompletion:(ArrayCompletion)completion {
  [[BBServerService sharedService] listPurchasesWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        completion(objects);
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

- (void)createDeliveryOnServerWithProgram: (BBOrderProgram *)orderProgram purchase:(BBPurchases *)purchase completion:(DeliveryCompletion)completion {
  NSMutableArray *arrayForTransport = [NSMutableArray array];
  for (NSDate __strong *date in orderProgram.days) {
    date = [[BBCalendarService sharedService] addTimeForDate:date hour:orderProgram.hour minute:orderProgram.minute];
    NSString *dat = [[BBCalendarService sharedService] stringForDate:date];
    NSDictionary *params = @{@"scheduled_for": dat,
                             @"address_id": [NSNumber numberWithInteger:orderProgram.address.addressId],
                             @"comment": orderProgram.commentOrder};
    [arrayForTransport addObject:params];
  }
  [[BBServerService sharedService] createDeliveriesWithApiToken:[[BBUserService sharedService] tokenUser]
                                                        purchId:[NSString stringWithFormat:@"%ld", (long) purchase.purchasesId]
                                                arrayDeliveries:arrayForTransport completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
                                                  if (response.kConnectionServer == kSuccessfullyConnection) {
                                                    if (response.serverError == kServerErrorSuccessfull) {
                                                      HQDispatchToMainQueue(^{
                                                        [[BBDataBaseService sharedService] addOrUpdateOrdersFromArray:objects callback:^{
                                                          [self deleteOrderProgramOnUserArray:orderProgram];
                                                          completion();
                                                        }];
                                                      });
                                                    } else {
                                                      completion();
                                                      [self.output errorServer];
                                                    }
                                                  } else {
                                                    completion();
                                                    [self.output errorNetwork];
                                                  }
                                                }];
}


- (NSArray *)deleteOrderProgramOnUserArray:(BBOrderProgram *)orderProgram {
  [[BBUserService sharedService] deleteInOrdersUserOrderProgram:orderProgram];
  return [[BBUserService sharedService] currentUser].ordersProgramArray;
}

- (void)deleteAllOrderProgramsOnUser {
  [[BBUserService sharedService] deleteAllOrderProgramInUser];
}

- (NSArray *)currentUserPayCards {
  return [[BBDataBaseService sharedService] curentPayCards];
}

@end
