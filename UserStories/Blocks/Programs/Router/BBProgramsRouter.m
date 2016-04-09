//
//  BBProgramsRouter.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsRouter.h"

#import "BBProgramsViewController.h"

@implementation BBProgramsRouter

#pragma mark - BBProgramsRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc; {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc pushViewController:vc animated:YES];
    });
}

@end