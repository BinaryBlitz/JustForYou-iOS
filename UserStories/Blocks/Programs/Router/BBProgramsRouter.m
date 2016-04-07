//
//  BBProgramsRouter.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsRouter.h"

@implementation BBProgramsRouter

#pragma mark - BBProgramsRouterInput

- (void)presentFromWindow:(UIWindow *)window {
    HQDispatchToMainQueue(^{
        [window setRootViewController:(UIViewController *)self.presenter.view];
        [window makeKeyAndVisible];
    });
}

@end