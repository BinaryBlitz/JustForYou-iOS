//
//  BBStockViewController.h
//  JustForYou
//
//  Created by tercteberc on 19/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BBStockViewInput.h"

@protocol BBStockViewOutput;

@interface BBStockViewController : UIViewController <BBStockViewInput>

@property (weak, nonatomic) id<BBStockViewOutput> output;

@end
