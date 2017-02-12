//
//  BBSettingsInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUserService.h"

@protocol BBSettingsInteractorInput <NSObject>

- (BBUser *)currentUser;

- (void)saveUser:(BBUser *)user;

- (void)logoutUser;

@end