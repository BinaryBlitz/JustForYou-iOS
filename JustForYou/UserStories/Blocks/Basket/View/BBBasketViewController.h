//
//  BBBasketViewController.h
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBBasketViewInput.h"

@protocol BBBasketViewOutput;

@interface BBBasketViewController : BBParentViewController <BBBasketViewInput>

@property (weak, nonatomic) id<BBBasketViewOutput> output;

@end
