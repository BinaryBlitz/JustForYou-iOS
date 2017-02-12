//
//  BBReplaceProgramRouter.m
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramRouter.h"

#import "BBServerService.h"
#import "BBUserService.h"
#import "BBTabbarViewController.h"

@implementation BBReplaceProgramRouter

#pragma mark - BBReplaceProgramRouterInput

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

- (void)updateCountPurchasesUser {
    UIViewController *view = (UIViewController *)self.presenter.view;
    [[BBServerService sharedService] updateUserCountsPurchasesWithUserToken:[[BBUserService sharedService] tokenUser] tabbar:(BBTabbarViewController *)view.tabBarController];
}

@end