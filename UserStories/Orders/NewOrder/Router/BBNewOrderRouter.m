//
//  BBNewOrderRouter.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderRouter.h"

@implementation BBNewOrderRouter

#pragma mark - BBNewOrderRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc pushViewController:vc animated:YES];
    });
}

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc {
    HQDispatchToMainQueue(^{
        [nc popViewControllerAnimated:YES];
    });
}

@end