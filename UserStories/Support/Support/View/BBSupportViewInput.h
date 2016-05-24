//
//  BBSupportViewInput.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBSupportViewInput <NSObject>

- (void)setupInitialState;

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message;

@end