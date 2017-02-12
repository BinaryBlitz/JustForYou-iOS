//
//  BBReplaceProgramModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBPurchases.h"

@protocol BBReplaceProgramModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule purchase:(BBPurchases *)purchase;
- (void)paySucces;

@end