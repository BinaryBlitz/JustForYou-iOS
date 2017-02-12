//
//  BBMyHistoryViewController.h
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBMyHistoryViewInput.h"

@protocol BBMyHistoryViewOutput;

@interface BBMyHistoryViewController : BBParentViewController <BBMyHistoryViewInput>

@property (weak, nonatomic) id<BBMyHistoryViewOutput> output;

@end
