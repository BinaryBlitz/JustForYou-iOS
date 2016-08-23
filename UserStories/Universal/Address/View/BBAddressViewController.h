//
//  BBAddressViewController.h
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBAddressViewInput.h"

@protocol BBAddressViewOutput;

@interface BBAddressViewController : BBParentViewController <BBAddressViewInput>

@property (weak, nonatomic) id<BBAddressViewOutput> output;

@end
