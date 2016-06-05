//
//  BBProfileViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBProfileViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)settingsButtonDidTap;

- (void)didSelectRowForKeyModule:(BBKeyModuleForUniversalModule)key;

- (void)viewWillAppear;

@end