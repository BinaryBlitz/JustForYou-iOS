//
//  BBBasketInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBPayment;

@protocol BBBasketInteractorOutput <NSObject>

- (void)currentOrders:(NSArray *)orders;

- (void)bonusesUpdate;

- (void)paymentDidStartWithPayment:(BBPayment *)payment;

- (void)paymentSuccessfull;
- (void)paymentError;

- (void)errorServer;
- (void)errorNetwork;

@end

