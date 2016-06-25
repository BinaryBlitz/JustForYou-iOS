//
//  BBMyHistoryInteractor.m
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyHistoryInteractor.h"

#import "BBMyHistoryInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBMyHistoryInteractor

#pragma mark - Методы BBMyHistoryInteractorInput

- (void)listMyHistoryOrder {
    [[BBServerService sharedService] listOrdersWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.serverError == kServerErrorSuccessfull) {
                [self.output ordersWithArray:objects];
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output errorNetwork];
        }
    }];
}

@end