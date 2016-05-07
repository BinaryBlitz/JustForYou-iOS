//
//  BBCardProgramRouterInput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBCardProgramRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

- (void)presentBasketViewControllerWithController:(UINavigationController *)basketNC
                         withNavigationController:(UINavigationController *)nc;

@end