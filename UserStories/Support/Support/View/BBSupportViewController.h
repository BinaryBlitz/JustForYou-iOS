//
//  BBSupportViewController.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBSupportViewInput.h"

@protocol BBSupportViewOutput;

@interface BBSupportViewController : BBParentViewController <BBSupportViewInput>

@property (weak, nonatomic) id<BBSupportViewOutput> output;

@end
