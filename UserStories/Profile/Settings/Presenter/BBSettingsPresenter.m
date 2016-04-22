//
//  BBSettingsPresenter.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsPresenter.h"

#import "BBSettingsViewInput.h"
#import "BBSettingsInteractorInput.h"
#import "BBSettingsRouterInput.h"

@interface BBSettingsPresenter()

@end

@implementation BBSettingsPresenter

#pragma mark - Методы BBSettingsModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBSettingsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBSettingsInteractorOutput

@end