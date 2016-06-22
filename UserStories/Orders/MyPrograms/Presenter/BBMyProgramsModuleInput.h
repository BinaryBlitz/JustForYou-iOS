//
//  BBMyProgramsModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBPurchases.h"

@protocol BBMyProgramsModuleInput <NSObject>

- (void)configureModule;
- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchasesArray:(NSArray *)purchases;
- (void)popViewControllerWithStatus:(BBStatusCreateDelivery)status;
@end