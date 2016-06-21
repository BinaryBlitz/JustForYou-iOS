//
//  BBReplacementViewInput.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBReplacementViewInput <NSObject>

- (void)setupInitialState;

- (NSInteger)countReplacementInTableView;

- (void)currentReplacementArray:(NSArray *)replacement;

- (void)presentAlertControllerWithMessage:(NSString *)message;

- (void)typeForController:(BBTypeReplacementController)type;

- (void)endUpdateTableViewWithNewReplacement:(NSArray *)replacement;

- (void)updateWithCategory:(NSArray *)category;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end