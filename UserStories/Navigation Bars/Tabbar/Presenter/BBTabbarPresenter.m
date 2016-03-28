//
//  BBTabbarPresenter.m
//  JustForYou
//
//  Created by tercteberc on 23/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTabbarPresenter.h"

#import "BBTabbarViewInput.h"
#import "BBTabbarInteractorInput.h"
#import "BBTabbarRouterInput.h"

#import "BBNavigationAssembly.h"
#import "BBNavigationModuleInput.h"

@interface BBTabbarPresenter()

@property (nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBTabbarPresenter

#pragma mark - Методы BBTabbarModuleInput

- (void)configureModule {
    // Стартовая конфигурация модуля, не привязанная к состоянию view
}

- (void)presentInWindow:(UIWindow *)window {
    [self.router presentFromWindow:window];
}

#pragma mark - Методы BBTabbarViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (id)needInitialViewForContainer {
    return [self.navigationModule currentView];
}

#pragma mark - Методы BBTabbarInteractorOutput


#pragma mark - Lazy Load

- (id<BBNavigationModuleInput>) navigationModule {
    if (!_navigationModule) {
        _navigationModule = [BBNavigationAssembly createModule];
    }
    return _navigationModule;
}

@end