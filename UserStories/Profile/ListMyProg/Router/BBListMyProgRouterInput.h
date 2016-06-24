//
//  BBListMyProgRouterInput.h
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBListMyProgRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end