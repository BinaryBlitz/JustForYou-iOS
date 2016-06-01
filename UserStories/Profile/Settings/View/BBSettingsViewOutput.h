//
//  BBSettingsViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBSettingsViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;
- (void)viewWillDisappear;


- (void)didSelectRowForKeyModule:(BBKeyModuleForUniversalModule)key;

@end