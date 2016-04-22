//
//  BBProfileModuleInput.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBProfileModuleInput <NSObject>

- (void)configureModule;

- (id)currentViewWithModule:(id)module;

@end