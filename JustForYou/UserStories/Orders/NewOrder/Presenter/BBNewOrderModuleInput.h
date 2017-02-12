//
//  BBNewOrderModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAddress.h"

@protocol BBNewOrderModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule purchase:(BBPurchases *)purchase parentModule:(id)parent;

- (void)selectionDates:(NSArray *)array;

- (void)popAdressModuleWithAdress:(BBAddress *)address;

@end