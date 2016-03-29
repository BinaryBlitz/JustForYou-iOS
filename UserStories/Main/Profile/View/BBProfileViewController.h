//
//  BBProfileViewController.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBProfileViewInput.h"

@protocol BBProfileViewOutput;

@interface BBProfileViewController : UIViewController <BBProfileViewInput>

@property (weak, nonatomic) id<BBProfileViewOutput> output;

@end
