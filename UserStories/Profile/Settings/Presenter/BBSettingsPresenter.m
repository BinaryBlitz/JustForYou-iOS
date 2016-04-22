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

#import "BBNavigationModuleInput.h"

@interface BBSettingsPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

@implementation BBSettingsPresenter

#pragma mark - Методы BBSettingsModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBSettingsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBSettingsInteractorOutput

@end