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