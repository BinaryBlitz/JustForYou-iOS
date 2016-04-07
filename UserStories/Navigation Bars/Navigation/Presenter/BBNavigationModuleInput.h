//
//  BBNavigationModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBNavigationModuleOutput.h"

@protocol BBNavigationModuleInput <NSObject>

- (id)currentViewWithLoadModule:(BBLoadModule) loadModule;

- (id)currentView;

- (void)configureModule;

- (void)presentInWindow:(UIWindow *)window;

- (void)userRegistrationFulfilled;

- (void)pushViewControllerWithView:(id)view;


@property (strong, nonatomic) id<BBNavigationModuleOutput> output;

@end