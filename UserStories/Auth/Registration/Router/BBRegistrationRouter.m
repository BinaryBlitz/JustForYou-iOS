//
//  BBRegistrationRouter.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationRouter.h"

#import "BBAuthorizationViewController.h"

@interface BBRegistrationRouter()

@property (weak, nonatomic) BBAuthorizationViewController *authView;

@end

@implementation BBRegistrationRouter

#pragma mark - BBRegistrationRouterInput

- (void)presentFromView:(id)view withNavigationView:(id)navigationView {
    self.authView = view;
    UINavigationController *nc = (UINavigationController *)navigationView;
    HQDispatchToMainQueue(^{
        [nc pushViewController:view animated:YES];
    });
}

@end