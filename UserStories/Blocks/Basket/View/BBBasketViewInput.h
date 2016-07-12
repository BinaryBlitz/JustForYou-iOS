//
//  BBBasketViewInput.h
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBBasketViewInput <NSObject>

- (void)setupInitialState;

- (void)updateTableViewWithOrders:(NSArray *)orders;
- (void)updateTableViewWithDelete:(NSArray *)objects;

- (void)updateTotalTableViewCell;
- (void)updateSwichInCellForState:(BOOL)state;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message titleAction:(NSString *)titleAction;

- (void)createAndPresentTableAlertWithMessage:(NSString *)message;

@end
