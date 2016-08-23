//
//  BBAddressModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBAddressModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parent;
- (void)popMapModuleWithAddress:(BBAddress *)address addressText:(NSString *)addressText;


@end