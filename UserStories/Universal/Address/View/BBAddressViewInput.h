//
//  BBAddressViewInput.h
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBAddressViewInput <NSObject>

- (void)setupInitialState;

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)updateTableViewWithAddress:(BBAddress *)address;


- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;

@end