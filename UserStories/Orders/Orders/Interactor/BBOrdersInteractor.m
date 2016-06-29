//
//  BBOrdersInteractor.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersInteractor.h"

#import "BBOrdersInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@interface BBOrdersInteractor()

@end

@implementation BBOrdersInteractor

#pragma mark - Методы BBOrdersInteractorInput

- (void)listMyDeliveriesOnDataBase {
    HQDispatchToMainQueue(^{
        [self.output currentMyDeliveriesWithArray:[[BBDataBaseService sharedService] ordersInRealm]];
    });
}

- (void)checkMyDeliveryInvoices {
    [[BBServerService sharedService] checkDeliveryInvoicesWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSData *data, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            id JSONObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (response.responseCode != 422) {
                if (response.serverError == kServerErrorSuccessfull) {
                    NSInteger invoicesId = [[JSONObj valueForKey:@"id"] integerValue];
                    NSInteger total = [[JSONObj valueForKey:@"total_price"] integerValue];
                    if (total >= 0) {
                        [[BBServerService sharedService] payDeliveryInvoicesWithApiToken:[[BBUserService sharedService] tokenUser]
                                                                              invoicesId:[NSString stringWithFormat:@"%ld", (long)invoicesId]
                                                                              completion:^(BBServerResponse *response, NSData *data, NSError *error) {
                                                                                  if (response.kConnectionServer == kSuccessfullyConnection) {
                                                                                      id Obj = [NSJSONSerialization
                                                                                                JSONObjectWithData:data
                                                                                                options:0
                                                                                                error:nil];
                                                                                      NSInteger payId = [[Obj valueForKey:@"id"] integerValue];
                                                                                      NSString *payUrl = [Obj valueForKey:@"payment_url"];
                                                                                      [self.output deliveryInvoicesWithPayId:payId
                                                                                                                      payURL:payUrl];
                                                                                  } else {
                                                                                      [self.output errorNetwork];
                                                                                  }
                        }];
                    }
                }
            } else {
                [self.output deliveryInvoicesNil];
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
                                                                     [[BBDataBaseService sharedService] addOrUpdateOrdersFromArray:objects];
                                                                     [self.output updateDeliveriesWithArray:[[BBDataBaseService sharedService] ordersInRealm]];
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