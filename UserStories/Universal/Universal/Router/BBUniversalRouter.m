//
//  BBUniversalRouter.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalRouter.h"

@implementation BBUniversalRouter

#pragma mark - BBUniversalRouterInput

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
