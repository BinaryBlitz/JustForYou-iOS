//
//  BBOrdersRouter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersRouter.h"

@implementation BBOrdersRouter

#pragma mark - BBOrdersRouterInput


- (void)popViewControllerWithNavigationController:(UINavigationController *)nc {
    HQDispatchToMainQueue(^{
        [nc popViewControllerAnimated:YES];
    });
}

- (void)presentFirstItemOnTabbar {
    HQDispatchToMainQueue(^{
        UIViewController *view = (UIViewController *)self.presenter.view;
        [view.tabBarController setSelectedIndex:0];
    });
}

@end