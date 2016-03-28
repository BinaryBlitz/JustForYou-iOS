//
//  BBTabbarModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBTabbarModuleInput <NSObject>

- (void)configureModule;

- (void)presentInWindow:(UIWindow *)window;

@end