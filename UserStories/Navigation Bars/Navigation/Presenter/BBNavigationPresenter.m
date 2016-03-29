//
//  BBNavigationPresenter.m
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNavigationPresenter.h"

#import "BBNavigationViewInput.h"
#import "BBNavigationInteractorInput.h"
#import "BBNavigationRouterInput.h"

#import "BBAuthorizationAssembly.h"
#import "BBAuthorizationModuleInput.h"

@interface BBNavigationPresenter()

@property (strong, nonatomic) id<BBAuthorizationModuleInput> authModule;

@end

@implementation BBNavigationPresenter

#pragma mark - Методы BBNavigationModuleInput

- (void)configureModule {
    
}

- (id)currentView {
    return self.view;
}

- (void)presentInWindow:(UIWindow *)window {
    [self.router presentFromWindow:window];
    [self.router rootVC:[self.authModule currentViewWithModule:self]];
}

#pragma mark - Методы BBNavigationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBNavigationInteractorOutput

#pragma mark - Lazy Load

- (id<BBAuthorizationModuleInput>) authModule {
    if (!_authModule) {
        _authModule = [BBAuthorizationAssembly createModule];
    }
    return _authModule;
}

@end