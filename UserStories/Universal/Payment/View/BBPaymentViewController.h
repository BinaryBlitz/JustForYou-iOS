//
//  BBPaymentViewController.h
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBPaymentViewInput.h"

@protocol BBPaymentViewOutput;

@interface BBPaymentViewController : UIViewController <BBPaymentViewInput>

@property (weak, nonatomic) id<BBPaymentViewOutput> output;

@end
