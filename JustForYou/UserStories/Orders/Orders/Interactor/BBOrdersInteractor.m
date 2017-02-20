#import "BBOrdersInteractor.h"

#import "BBOrdersInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@interface BBOrdersInteractor ()

@end

@implementation BBOrdersInteractor

#pragma mark - Методы BBOrdersInteractorInput

- (void)listMyDeliveriesOnDataBase {
  HQDispatchToMainQueue(^{
    [self.output currentMyDeliveriesWithArray:[[BBDataBaseService sharedService] ordersInRealm]];
  });
}

- (void)deleteOrderWithOrder:(BBOrder *)order {
  __block NSInteger orderId = order.orderId;
  [[BBServerService sharedService] cancelDeliveryWithApiToken:[[BBUserService sharedService] tokenUser]
                                                   deliveryId:[NSString stringWithFormat:@"%ld", (long) order.orderId]
                                                   completion:^(BBServerResponse *response, NSError *error) {
                                                     if (response.kConnectionServer == kSuccessfullyConnection) {
                                                       if (response.serverError == kServerErrorSuccessfull) {
                                                         HQDispatchToMainQueue(^{
                                                           [[BBDataBaseService sharedService] deleteOrderForOrderId:orderId callback:^{
                                                             [self.output deliveriesDeleted];
                                                           }];
                                                         });
//                                                                 [[BBDataBaseService sharedService] deleteOrderForOrderId:orderId];
                                                       } else {
                                                         [self.output errorServer];
                                                       }
                                                     } else {
                                                       [self.output errorNetwork];
                                                     }
                                                   }];
}

- (void)checkMyDeliveryInvoices {
  [[BBServerService sharedService] checkDeliveryInvoicesWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSData *data, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (data) {
        id JSONObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (response.responseCode != 422) {
          if (response.serverError == kServerErrorSuccessfull) {
            NSInteger invoicesId = [[JSONObj valueForKey:@"id"] integerValue];
            NSInteger total = [[JSONObj valueForKey:@"total_price"] integerValue];
            [self.output createPayDeliveriesWithTotal:total invoicesId:invoicesId];
          } else {
            [self.output errorServer];
          }
        } else {
          [self.output deliveryInvoicesNil];
        }
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

- (void)payDeliveriesWithTotal:(NSInteger)total invoicesId:(NSInteger)invoicesId card:(BBPayCard *)card {
  [[BBServerService sharedService] payDeliveryInvoicesWithApiToken:[[BBUserService sharedService] tokenUser]
                                                        invoicesId:[NSString stringWithFormat:@"%ld", (long) invoicesId]
                                                            cardId:card.payCardId
                                                        completion:^(BBServerResponse *response, NSData *data, NSError *error) {
                                                          if (response.kConnectionServer == kSuccessfullyConnection) {
                                                            if (response.serverError == kServerErrorSuccessfull) {
                                                              id Obj = [NSJSONSerialization
                                                                  JSONObjectWithData:data
                                                                             options:0
                                                                               error:nil];
                                                              NSInteger payId = [[Obj valueForKey:@"id"] integerValue];
                                                              NSString *payUrl = [Obj valueForKey:@"payment_url"];
                                                              BOOL paid = [[Obj valueForKey:@"paid"] boolValue];
                                                              if (paid) {
                                                                [self.output paymentSuccessfull];
                                                              } else {
                                                                [self.output deliveryInvoicesWithPayId:payId payURL:payUrl];
                                                              }
                                                            } else if (response.responseCode == 422) {
                                                              [self.output paymentSuccessfull];
                                                            } else {
                                                              [self.output errorServer];
                                                            }
                                                          } else {
                                                            [self.output errorNetwork];
                                                          }
                                                        }];
}

- (void)payOnServerWithPayCard:(BBPayCard *)card paiId:(NSInteger)paiId {
  [[BBServerService sharedService] createPaymentsWithPayCard:card.payCardId orderId:paiId apiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BOOL paid, NSError *error) {
    if (paid) {
      [self.output paymentSuccessfull];
    } else {
      [self.output paymentError];
    }
  }];
}

- (void)myDeliveriesOnServer {
  [[BBServerService sharedService] listDeliveriesWithApiToken:[[BBUserService sharedService] tokenUser]
                                                   completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
                                                     if (response.kConnectionServer == kSuccessfullyConnection) {
                                                       if (response.serverError == kServerErrorSuccessfull) {
                                                         HQDispatchToMainQueue(^{
                                                           [[BBDataBaseService sharedService] addOrUpdateOrdersFromArray:objects callback:^{
                                                             HQDispatchToMainQueue(^{
                                                               [self.output updateDeliveriesWithArray:[[BBDataBaseService sharedService] ordersInRealm]];
                                                             });
                                                           }];
//                                                                     [[BBDataBaseService sharedService] addOrUpdateOrdersFromArray:objects];
                                                         });
                                                       }
                                                     }
                                                   }];
}

- (void)listPurchasesUser {
  [[BBServerService sharedService] listPurchasesWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
    if (response.kConnectionServer == kSuccessfullyConnection) {
      if (response.serverError == kServerErrorSuccessfull) {
        [self.output currentPurchasesUserWithArray:objects];
      } else {
        [self.output errorServer];
      }
    } else {
      [self.output errorNetwork];
    }
  }];
}

@end
