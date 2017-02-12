//
//  BBNavigationRouter.m
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNavigationRouter.h"

@implementation BBNavigationRouter

#pragma mark - BBNavigationRouterInput

- (void)presentFromWindow:(UIWindow *)window {
    HQDispatchToMainQueue(^{
        [window setRootViewController:(UIViewController *)self.presenter.view];
        [window makeKeyAndVisible];
    });
}

- (void)rootVC:(id)view {
    UINavigationController *nc = (UINavigationController *)self.presenter.view;
    nc.viewControllers = @[view];
}

- (void)popToRootViewController {
    UINavigationController *nc = (UINavigationController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc popToRootViewControllerAnimated:NO];
    });
}

- (void)pushViewController:(id)view {
    UINavigationController *nc = (UINavigationController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc pushViewController:view animated:YES];
    });
}

@end