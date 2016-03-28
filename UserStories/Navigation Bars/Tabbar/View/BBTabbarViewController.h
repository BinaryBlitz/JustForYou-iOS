//
//  BBTabbarViewController.h
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBTabbarViewInput.h"

@protocol BBTabbarViewOutput;

@interface BBTabbarViewController : UIViewController <BBTabbarViewInput>

@property (weak, nonatomic) id<BBTabbarViewOutput> output;

@end
