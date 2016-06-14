//
//  BBUniversalRouterInput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBUniversalRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;

@end
