//
//  BBTabbarModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBTabbarModuleOutput.h"

@protocol BBTabbarModuleInput <NSObject>

- (void)configureModule;

- (id)currentView;

- (void)userLogout;

- (void)presentInWindow:(UIWindow *)window;

@property (strong, nonatomic) id<BBTabbarModuleOutput> output;

@end