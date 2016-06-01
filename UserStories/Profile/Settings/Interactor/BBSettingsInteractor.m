//
//  BBSettingsInteractor.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsInteractor.h"

#import "BBSettingsInteractorOutput.h"

@implementation BBSettingsInteractor

#pragma mark - Методы BBSettingsInteractorInput

- (BBUser *)currentUser {
    return [[BBUserService sharedService] currentUser];
}

- (void)saveUser:(BBUser *)user {
    [[BBUserService sharedService] saveCurrentUser:user];
}

@end