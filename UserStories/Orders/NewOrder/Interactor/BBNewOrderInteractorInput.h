//
//  BBNewOrderInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBNewOrderInteractorInput <NSObject>

- (void)createDeliveryOnServerWithDays:(NSArray *)days address:(BBAddress *)address purchase:(BBPurchases *)purchase coment:(NSString *)coment hour:(NSInteger)hour minute:(NSInteger)minute;

@end