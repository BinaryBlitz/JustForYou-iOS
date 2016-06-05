//
//  BBProfileInteractor.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfileInteractor.h"

#import "BBProfileInteractorOutput.h"

#import "BBUserService.h"

@implementation BBProfileInteractor

#pragma mark - Методы BBProfileInteractorInput

- (void)currentUser {
    [self.output currentUserWithUser:[[BBUserService sharedService] currentUser]];
}

@end