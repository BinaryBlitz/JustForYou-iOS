//
//  BBProgramsViewController.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBProgramsViewInput.h"

@protocol BBProgramsViewOutput;

@interface BBProgramsViewController : UIViewController <BBProgramsViewInput>

@property (weak, nonatomic) id<BBProgramsViewOutput> output;

@end
