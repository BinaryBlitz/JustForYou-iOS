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


- (void)pushView:(id)view withNavigationController:(UINavigationController *)nc {
    HQDispatchToMainQueue(^{
        [nc pushViewController:view animated:YES];
    });
}
@end