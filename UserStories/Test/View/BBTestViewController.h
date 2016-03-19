//
//  BBTestViewController.h
//  JustForYou
//
//  Created by tercteberc on 19/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBTestViewInput.h"

@protocol BBTestViewOutput;

@interface BBTestViewController : UIViewController <BBTestViewInput>

@property (nonatomic, weak) id<BBTestViewOutput> output;

@end
