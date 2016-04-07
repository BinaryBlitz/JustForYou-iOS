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

#import "BBBlocksAssembly.h"
#import "BBBlocksModuleInput.h"

#import "BBOrdersAssembly.h"
#import "BBOrdersModuleInput.h"

@interface BBNavigationPresenter()

@property (strong, nonatomic) id<BBAuthorizationModuleInput> authModule;
@property (strong, nonatomic) id<BBBlocksModuleInput> blockModule;
@property (strong, nonatomic) id<BBOrdersModuleInput> orderModule;

@property (nonatomic) BBLoadModule loadModule;

@end

@implementation BBNavigationPresenter
@synthesize output;

#pragma mark - Методы BBNavigationModuleInput

- (void)configureModule {
    self.loadModule = BBRegistrationModule;
}

- (id)currentViewWithLoadModule:(BBLoadModule) loadModule {
    self.loadModule = loadModule;
    return self.view;
}

- (id)currentView {
    return self.view;
}

- (void)pushViewControllerWithView:(id)view {
    [self.router pushViewController:view];
}

- (void)presentInWindow:(UIWindow *)window {
    [self.router presentFromWindow:window];
}

#warning delete after test

- (void)userRegistrationFulfilled {
//    [self.output userRegistrationFulfilledWithView:[self.view currentView]];
    [self.output userRegistrationFulfilled];
}

#pragma mark - Методы BBNavigationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    if (self.loadModule == BBRegistrationModule) {
        [self.router rootVC:[self.authModule currentViewWithModule:self]];
    } else if (self.loadModule == BBLoadBlockModule) {
        [self.router rootVC:[self.blockModule currentViewWithModule:self]];
    } else {
        [self.router rootVC:[self.orderModule currentViewWithModule:self]];
    }
}

#pragma mark - Методы BBNavigationInteractorOutput

#pragma mark - Lazy Load

- (id<BBAuthorizationModuleInput>) authModule {
    if (!_authModule) {
        _authModule = [BBAuthorizationAssembly createModule];
    }
    return _authModule;
}

- (id<BBBlocksModuleInput>) blockModule {
    if (!_blockModule) {
        _blockModule = [BBBlocksAssembly createModule];
    }
    return _blockModule;
}

- (id<BBOrdersModuleInput>) orderModule {
    if (!_orderModule) {
        _orderModule = [BBOrdersAssembly createModule];
    }
    return _orderModule;
}

@end