//
//  BBAuthorizationViewController.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBAuthorizationViewInput.h"

@protocol BBAuthorizationViewOutput;

@interface BBAuthorizationViewController : UIViewController <BBAuthorizationViewInput>

@property (nonatomic, weak) id<BBAuthorizationViewOutput> output;

@end
