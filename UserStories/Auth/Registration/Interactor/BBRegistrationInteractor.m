//
//  BBRegistrationInteractor.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationInteractor.h"

#import "BBRegistrationInteractorOutput.h"

#import "BBUserService.h"

@implementation BBRegistrationInteractor

#pragma mark - Методы BBRegistrationInteractorInput

- (void)saveUser:(BBUser *)user {
    [[BBUserService sharedService] saveCurrentUser:user];
    [self.output userSuccessfullySaved];
}

@end