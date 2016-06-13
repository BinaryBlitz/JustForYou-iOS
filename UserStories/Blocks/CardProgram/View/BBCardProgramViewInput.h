//
//  BBCardProgramViewInput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBProgram.h"

@protocol BBCardProgramViewInput <NSObject>

- (void)setupInitialState;

- (void)updateViewWithProgram:(NSInteger)parentId;

- (void)changeImageAndPresentAlertControllerWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle;

- (void)showAddInBasketPopover;

- (void)showLoaderView;
- (void)hideLoaderView;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end