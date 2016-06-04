//
//  BBSettingsViewInput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"

@protocol BBSettingsViewInput <NSObject>

- (void)setupInitialState;

- (BBUser *)currentInfoUser;

- (void)updateInfoUserWithUser:(BBUser *)user;

- (void)showLoaderView;
- (void)hideLoaderView;

@end