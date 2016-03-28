//
//  BBAuthorizationModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBAuthorizationModuleInput <NSObject>

- (void)configureModule;

- (id)currentViewWithModule:(id)module;
- (id)currentView;


@end