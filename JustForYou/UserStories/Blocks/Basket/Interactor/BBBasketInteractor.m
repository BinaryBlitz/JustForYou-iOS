#import "BBBasketInteractor.h"

#import "BBBasketInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@implementation BBBasketInteractor

#pragma mark - Методы BBBasketInteractorInput

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
  [[BBServerService sharedService] createOrderWithOrders:user.ordersProgramArray
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
                                                          [self.output paymentSuccessfull];
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
