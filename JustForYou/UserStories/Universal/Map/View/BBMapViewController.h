//
//  BBMapViewController.h
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBMapViewInput.h"

@protocol BBMapViewOutput;

@interface BBMapViewController : BBParentViewController <BBMapViewInput>

@property (weak, nonatomic) id<BBMapViewOutput> output;

@end
