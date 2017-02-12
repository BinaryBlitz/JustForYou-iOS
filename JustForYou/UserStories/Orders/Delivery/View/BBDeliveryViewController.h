//
//  BBDeliveryViewController.h
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBDeliveryViewInput.h"
#import "BBOrderViewControllerDelegate.h"

@protocol BBDeliveryViewOutput;

@interface BBDeliveryViewController : BBParentViewController <BBDeliveryViewInput>

@property (weak, nonatomic) id<BBDeliveryViewOutput> output;

@property (strong, nonatomic) id<BBOrderViewControllerDelegate> delegate;

@end
