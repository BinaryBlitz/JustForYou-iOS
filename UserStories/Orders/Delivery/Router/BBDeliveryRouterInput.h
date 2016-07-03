//
//  BBDeliveryRouterInput.h
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBDeliveryRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;
- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;

@end