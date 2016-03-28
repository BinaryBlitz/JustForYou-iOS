//
//  BBRegistrationViewController.h
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBRegistrationViewInput.h"

@protocol BBRegistrationViewOutput;

@interface BBRegistrationViewController : UIViewController <BBRegistrationViewInput>

@property (weak, nonatomic) id<BBRegistrationViewOutput> output;

@end
