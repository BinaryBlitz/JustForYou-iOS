//
//  BBPaymentViewInput.h
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBPayment.h"

@protocol BBPaymentViewInput <NSObject>

- (void)setupInitialState;

- (void)loadWebViewWithPayment:(BBPayment *)payment;

@end
