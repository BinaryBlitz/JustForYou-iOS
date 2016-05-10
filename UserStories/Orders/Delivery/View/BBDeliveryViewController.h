//
//  BBDeliveryViewController.h
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBDeliveryViewInput.h"

@protocol BBDeliveryViewOutput;

@interface BBDeliveryViewController : UIViewController <BBDeliveryViewInput>

@property (weak, nonatomic) id<BBDeliveryViewOutput> output;

@end
