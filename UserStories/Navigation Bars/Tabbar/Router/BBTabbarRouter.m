//
//  BBTabbarRouter.m
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTabbarRouter.h"

@implementation BBTabbarRouter

#pragma mark - BBTabbarRouterInput

- (void)presentFromWindow:(UIWindow *)window {
    HQDispatchToMainQueue(^{
        [window setRootViewController:(UIViewController *)self.presenter.view];
        [window makeKeyAndVisible];
    });
}

@end