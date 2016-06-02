//
//  BBAuthorizationViewInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kNumberPhoneStyleTableView,
    kSendCodeStyleTableView
}BBKeyStyleTableViewRegist;

@protocol BBAuthorizationViewInput <NSObject>

- (void)setupInitialState;

- (void)showLoaderView;
- (void)hideLoaderView;

- (void)getNumberPhoneUser;

- (void)updateTableViewWithKeyTableView:(BBKeyStyleTableViewRegist)key;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end