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

@implementation BBBasketInteractor

#pragma mark - Методы BBBasketInteractorInput

- (void)currentOrdersInBasket {
    BBUser *user = [[BBUserService sharedService] currentUser];
    [self.output currentOrders:user.ordersProgramArray];
}

- (void)createOrderOnServer {
    BBUser *user = [[BBUserService sharedService] currentUser];
    [[BBServerService sharedService] createOrderWithOrders:user.ordersProgramArray apiToken:[[BBUserService sharedService] tokenUser] numberPhone:user.numberPhone completion:^(BBServerResponse *response, NSInteger orderId, NSError *error) {
        if (response.responseCode == 201) {
            [[BBServerService sharedService] createPaymentsWithOrderId:orderId apiToken:[[BBUserService sharedService] tokenUser]  completion:^(BBServerResponse *response, BBPayment *payment, NSError *error) {
                if (payment) {
                    [self.output paymentDidStartWithPayment:payment];
                }
            }];
        }
    }];
}

- (NSArray *)deleteOrderProgramOnUserArray:(BBOrderProgram *)orderProgram {
    [[BBUserService sharedService] deleteInOrdersUserOrderProgram:orderProgram];
    return [[BBUserService sharedService] currentUser].ordersProgramArray;
}

@end
