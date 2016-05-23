//
//  BBUniversalViewInput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBUniversalViewInput <NSObject>

- (void)setupInitialState;

- (void)navigationTitle:(NSString *)title keyModule:(BBKeyModuleForUniversalModule)key;

- (void)settingView;

@end