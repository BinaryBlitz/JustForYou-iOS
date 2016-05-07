//
//  BBBasketRouter.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketRouter.h"

@interface BBBasketRouter()

@end

@implementation BBBasketRouter

#pragma mark - BBBasketRouterInput

- (void)dissmissViewControllerWithNavigation:(UINavigationController *)nc {
    HQDispatchToMainQueue(^{
        [nc dismissViewControllerAnimated:YES completion:nil];
    });
}

@end