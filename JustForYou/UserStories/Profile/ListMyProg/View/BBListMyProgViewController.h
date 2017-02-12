//
//  BBListMyProgViewController.h
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBListMyProgViewInput.h"

@protocol BBListMyProgViewOutput;

@interface BBListMyProgViewController : BBParentViewController <BBListMyProgViewInput>

@property (weak, nonatomic) id<BBListMyProgViewOutput> output;

@end
