//
//  BBUniversalViewController.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBUniversalViewInput.h"

@protocol BBUniversalViewOutput;

@interface BBUniversalViewController : BBParentViewController <BBUniversalViewInput>

@property (weak, nonatomic) id<BBUniversalViewOutput> output;

@end
