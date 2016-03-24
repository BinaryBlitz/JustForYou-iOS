//
//  BBNavigationModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBNavigationModuleInput <NSObject>

- (void)configureModule;

- (id)currentView;

@end