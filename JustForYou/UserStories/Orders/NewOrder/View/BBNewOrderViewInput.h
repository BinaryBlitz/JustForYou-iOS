//
//  BBNewOrderViewInput.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBPurchases.h"

@protocol BBNewOrderViewInput <NSObject>

- (void)setupInitialState;

- (void)purchaseWithPurchase:(BBPurchases *)purchase;
- (void)countsDaysInCalendar:(NSInteger)counts;

- (void)adressForAdressTableViewCell:(NSString *)adress;
- (void)deleteAddress;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentFinishAlertWithTitle:(NSString *)title message:(NSString *)message;

@end