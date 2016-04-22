//
//  BBCardProgramRouter.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramRouter.h"

@implementation BBCardProgramRouter

#pragma mark - BBCardProgramRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc; {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc pushViewController:vc animated:YES];
    });
}

@end