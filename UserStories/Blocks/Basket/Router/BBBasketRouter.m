//
//  BBBasketRouter.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketRouter.h"

#import "BBServerService.h"
#import "BBUserService.h"
#import "BBTabbarViewController.h"

@interface BBBasketRouter()

@end

@implementation BBBasketRouter

#pragma mark - BBBasketRouterInput

- (void)dissmissViewControllerWithNavigation:(UINavigationController *)nc {
    HQDispatchToMainQueue(^{
        [nc dismissViewControllerAnimated:YES completion:nil];
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