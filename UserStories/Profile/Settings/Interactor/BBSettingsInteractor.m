//
//  BBSettingsInteractor.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsInteractor.h"

#import "BBSettingsInteractorOutput.h"

#import "BBServerService.h"

@implementation BBSettingsInteractor

#pragma mark - Методы BBSettingsInteractorInput

- (BBUser *)currentUser {
    return [[BBUserService sharedService] currentUser];
}

- (void)saveUser:(BBUser *)user {
    [[BBServerService sharedService] updateUserWithUser:user completion:^(BBServerServiceConnection key, BBUser *user, NSError *error) {
        if (key == kSuccessfullyConnection) {
            if (user) {
                [[BBUserService sharedService] saveCurrentUser:user];
                [self.output updateUserSuccessfully];
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output noConnectionNetwork];
        }

    }];
}

@end