//
//  BBNewOrderViewController.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBNewOrderViewInput.h"

@protocol BBNewOrderViewOutput;

@interface BBNewOrderViewController : BBParentViewController <BBNewOrderViewInput>

@property (weak, nonatomic) id<BBNewOrderViewOutput> output;

@end
