//
//  BBListMyProgModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBListMyProgModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule;

@end