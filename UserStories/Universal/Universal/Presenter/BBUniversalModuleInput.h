//
//  BBUniversalModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBUniversalModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule keyModule:(BBKeyModuleForUniversalModule)key;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule keyModule:(BBKeyModuleForUniversalModule)key;

- (void)popMapModuleWithStatus:(BOOL)status;

@end
