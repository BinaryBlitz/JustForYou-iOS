//
//  BBProfileViewInput.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"

@protocol BBProfileViewInput <NSObject>

- (void)setupInitialState;

- (void)currentUser:(BBUser *)user;

@end