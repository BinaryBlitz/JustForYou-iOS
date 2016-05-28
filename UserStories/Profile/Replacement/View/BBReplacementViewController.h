//
//  BBReplacementViewController.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBReplacementViewInput.h"

@protocol BBReplacementViewOutput;

@interface BBReplacementViewController : UIViewController <BBReplacementViewInput>

@property (weak, nonatomic) id<BBReplacementViewOutput> output;

@end
