//
//  BBGreetingViewController.h
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBGreetingViewInput.h"

@protocol BBGreetingViewOutput;

@interface BBGreetingViewController : BBParentViewController <BBGreetingViewInput>

@property (weak, nonatomic) id<BBGreetingViewOutput> output;

@end
