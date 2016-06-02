//
//  BBRegistrationViewInput.h
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"

@protocol BBRegistrationViewInput <NSObject>

- (void)setupInitialState;

- (BBUser *)userWithTextFields;

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end