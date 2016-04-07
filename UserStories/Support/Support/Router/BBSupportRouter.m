//
//  BBSupportRouter.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportRouter.h"

@implementation BBSupportRouter

#pragma mark - BBSupportRouterInput

- (void)presentFromWindow:(UIWindow *)window {
    HQDispatchToMainQueue(^{
        [window setRootViewController:(UIViewController *)self.presenter.view];
        [window makeKeyAndVisible];
    });
}

@end