//
//  BBMyProgramsInteractor.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyProgramsInteractor.h"

#import "BBMyProgramsInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBMyProgramsInteractor

#pragma mark - Методы BBMyProgramsInteractorInput

- (void)listPurchasesUser {
    [[BBServerService sharedService] listPurchasesWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.serverError == kServerErrorSuccessfull) {
                [self.output currentPurchasesUserWithArray:objects];
            }
        } else {
            [self.output errorNetwork];
        }
    }];
}

@end