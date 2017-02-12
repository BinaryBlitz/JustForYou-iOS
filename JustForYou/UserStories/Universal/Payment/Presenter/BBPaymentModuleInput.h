//
//  BBPaymentModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBPayment;

@protocol BBPaymentModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule basketModule:(id)basketModule payment:(BBPayment *)payment;

@end
