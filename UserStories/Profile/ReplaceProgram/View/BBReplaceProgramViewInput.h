//
//  BBReplaceProgramViewInput.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBReplaceProgramViewInput <NSObject>

- (void)setupInitialState;

- (void)updateTableViewWithArray:(NSArray *)programs;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message titleAction:(NSString *)titleAction;

- (void)createAndPresentTableAlertWithMessage:(NSString *)message;

@end