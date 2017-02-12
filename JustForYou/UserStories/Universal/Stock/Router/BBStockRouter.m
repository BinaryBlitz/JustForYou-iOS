//
//  BBStockRouter.m
//  JustForYou
//
//  Created by tercteberc on 19/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBStockRouter.h"

@implementation BBStockRouter

#pragma mark - BBStockRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc pushViewController:vc animated:YES];
    });
}

@end