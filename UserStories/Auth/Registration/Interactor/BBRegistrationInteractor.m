//
//  BBRegistrationInteractor.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationInteractor.h"

#import "BBRegistrationInteractorOutput.h"

#import "BBServerService.h"

#import "BBUserService.h"

@implementation BBRegistrationInteractor

#pragma mark - Методы BBRegistrationInteractorInput

- (void)saveAndSendUser:(BBUser *)user {
    
    [[BBServerService sharedService] createUserWithUser:user completion:^(BBServerServiceConnection key, BBUser *user, NSError *error) {
        
    }];
//    [[BBUserService sharedService] saveCurrentUser:user];
//    [self.output userSuccessfullySaved];
}

@end