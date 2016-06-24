//
//  BBListMyProgViewInput.h
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBListMyProgViewInput <NSObject>

- (void)setupInitialState;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)updateTableViewWithArrayObjects:(NSArray *)objects;

@end