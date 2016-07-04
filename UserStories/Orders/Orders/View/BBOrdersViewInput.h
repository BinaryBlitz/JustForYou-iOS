//
//  BBOrdersViewInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBOrdersViewInput <NSObject>

- (void)setupInitialState;

- (void)updateDeliveriesWithArray:(NSArray *)deliveries;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)createAndPresentTableAlertWithMessage:(NSString *)message;
- (void)presentAlertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                            titleAction:(NSString *)titleAction
                            cancelTitle:(NSString *)cancel
                                    key:(BBKeyForOkButtonAlert)key;

@end