//
//  BBCardProgramViewController.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBCardProgramViewInput.h"

@protocol BBCardProgramViewOutput;

@interface BBCardProgramViewController : BBParentViewController <BBCardProgramViewInput>

@property (weak, nonatomic) id<BBCardProgramViewOutput> output;

@end
