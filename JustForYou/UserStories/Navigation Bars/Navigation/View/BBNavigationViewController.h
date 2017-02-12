//
//  BBNavigationViewController.h
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBNavigationViewInput.h"

@protocol BBNavigationViewOutput;

@interface BBNavigationViewController : UINavigationController <BBNavigationViewInput>

@property (weak, nonatomic) id<BBNavigationViewOutput> output;

@end
