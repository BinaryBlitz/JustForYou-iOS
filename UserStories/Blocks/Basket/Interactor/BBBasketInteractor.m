//
//  BBBasketInteractor.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketInteractor.h"

#import "BBBasketInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@implementation BBBasketInteractor

#pragma mark - Методы BBBasketInteractorInput

- (void)currentOrdersInBasket {
    BBUser *user = [[BBUserService sharedService] currentUser];
    [self.output currentOrders:user.ordersProgramArray];
}

- (void)createOrderOnServerWithTypePayment:(BBTypePayment)type payCard:(BBPayCard *)card {
    BBUser *user = [[BBUserService sharedService] currentUser];
    [[BBServerService sharedService] createOrderWithOrders:user.ordersProgramArray apiToken:[[BBUserService sharedService] tokenUser] numberPhone:user.numberPhone completion:^(BBServerResponse *response, NSInteger orderId, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.responseCode == 201) {
                if (type == kTypeNewPayment) {
                    [[BBServerService sharedService] createPaymentsWithOrderId:orderId apiToken:[[BBUserService sharedService] tokenUser]  completion:^(BBServerResponse *response, BBPayment *payment, NSError *error) {
                        if (payment) {
                            [self.output paymentDidStartWithPayment:payment];
                        }
                    }];
                } else {
                    [[BBServerService sharedService] createPaymentsWithPayCard:card orderId:orderId apiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BOOL paid, NSError *error) {
                        if (paid) {
                            [self.output paymentSuccessfull];
                        } else {
                            [self.output paymentError];
                        }
                    }];
                }
                
            } else  {
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
