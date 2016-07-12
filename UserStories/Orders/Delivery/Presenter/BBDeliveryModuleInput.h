//
//  BBDeliveryModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBDeliveryModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchase:(BBPurchases *)purchase daysArray:(NSArray *)days;

@end