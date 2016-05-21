//
//  BBGreetingRouterInput.h
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBGreetingRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end