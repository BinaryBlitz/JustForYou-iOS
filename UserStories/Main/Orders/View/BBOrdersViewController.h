//
//  BBOrdersViewController.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBOrdersViewInput.h"

@protocol BBOrdersViewOutput;

@interface BBOrdersViewController : UIViewController <BBOrdersViewInput>

@property (weak, nonatomic) id<BBOrdersViewOutput> output;

@end
