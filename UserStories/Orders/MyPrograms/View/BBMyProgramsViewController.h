//
//  BBMyProgramsViewController.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBMyProgramsViewInput.h"

@protocol BBMyProgramsViewOutput;

@interface BBMyProgramsViewController : UIViewController <BBMyProgramsViewInput>

@property (weak, nonatomic) id<BBMyProgramsViewOutput> output;

@end
