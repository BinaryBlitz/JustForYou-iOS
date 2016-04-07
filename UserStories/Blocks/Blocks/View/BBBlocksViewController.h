//
//  BBBlocksViewController.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBBlocksViewInput.h"

@protocol BBBlocksViewOutput;

@interface BBBlocksViewController : UIViewController <BBBlocksViewInput>

@property (weak, nonatomic) id<BBBlocksViewOutput> output;

@end
