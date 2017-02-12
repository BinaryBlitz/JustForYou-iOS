//
//  BBSettingsViewController.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBSettingsViewInput.h"

@protocol BBSettingsViewOutput;

@interface BBSettingsViewController : BBParentViewController <BBSettingsViewInput>

@property (weak, nonatomic) id<BBSettingsViewOutput> output;

@end
