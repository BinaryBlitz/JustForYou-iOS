//
//  BBProfilePresenter.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfilePresenter.h"

#import "BBProfileViewInput.h"
#import "BBProfileInteractorInput.h"
#import "BBProfileRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBSettingsAssembly.h"
#import "BBSettingsModuleInput.h"

#import "BBUniversalAssembly.h"
#import "BBUniversalModuleInput.h"

@interface BBProfilePresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBSettingsModuleInput> settingsModule;
@property (strong, nonatomic) id<BBUniversalModuleInput> universalModule;

@end

@implementation BBProfilePresenter

#pragma mark - Методы BBProfileModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigationModule = module;
    return self.view;
}

#pragma mark - Методы BBProfileViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)settingsButtonDidTap {
    [self.settingsModule pushModuleWithNavigationModule:self.navigationModule];
}

- (void)didSelectRowForKeyModule:(BBKeyModuleForUniversalModule)key {
    [self.universalModule pushModuleWithNavigationModule:self.navigationModule keyModule:key];
}

#pragma mark - Методы BBProfileInteractorOutput

#pragma mark - Lazy Load

- (id<BBSettingsModuleInput>) settingsModule {
    if (!_settingsModule) {
        _settingsModule = [BBSettingsAssembly createModule];
    }
    return _settingsModule;
}

- (id<BBUniversalModuleInput>) universalModule {
    if (!_universalModule) {
        _universalModule = [BBUniversalAssembly createModule];
    }
    return _universalModule;
}

@end