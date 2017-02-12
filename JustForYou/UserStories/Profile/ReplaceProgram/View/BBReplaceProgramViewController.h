//
//  BBReplaceProgramViewController.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBReplaceProgramViewInput.h"

@protocol BBReplaceProgramViewOutput;

@interface BBReplaceProgramViewController : BBParentViewController <BBReplaceProgramViewInput>

@property (weak, nonatomic) id<BBReplaceProgramViewOutput> output;

@end
