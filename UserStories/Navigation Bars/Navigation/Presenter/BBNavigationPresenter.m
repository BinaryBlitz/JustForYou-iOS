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

#import "BBSupportAssembly.h"
#import "BBSupportModuleInput.h"

#import "BBProfileAssembly.h"
#import "BBProfileModuleInput.h"

#import "BBBasketAssembly.h"
#import "BBBasketModuleInput.h"

@interface BBNavigationPresenter()

@property (strong, nonatomic) id<BBAuthorizationModuleInput> authModule;
@property (strong, nonatomic) id<BBBlocksModuleInput> blockModule;
@property (strong, nonatomic) id<BBOrdersModuleInput> orderModule;
@property (strong, nonatomic) id<BBSupportModuleInput> supportModule;
@property (strong, nonatomic) id<BBProfileModuleInput> profileModule;
@property (strong, nonatomic) id<BBBasketModuleInput> basketModule;

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

- (void)userRegistrationFulfilled {
    [self.output userRegistrationFulfilled];
}

#pragma mark - Методы BBNavigationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    if (self.loadModule == BBRegistrationModule) {
        [self.router rootVC:[self.authModule currentViewWithModule:self]];
    } else if (self.loadModule == BBLoadBlockModule) {
        [self.router rootVC:[self.blockModule currentViewWithModule:self]];
    } else if (self.loadModule == BBLoadOrdersModule) {
        [self.router rootVC:[self.orderModule currentViewWithModule:self]];
    } else if (self.loadModule == BBLoadSupportModule) {
        [self.router rootVC:[self.supportModule currentViewWithModule:self]];
    } else if (self.loadModule == BBLoadProfileModule) {
        [self.router rootVC:[self.profileModule currentViewWithModule:self]];
    } else {
        [self.router rootVC:[self.basketModule currentViewWithModule:self]];
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

- (id<BBSupportModuleInput>) supportModule {
    if (!_supportModule) {
        _supportModule = [BBSupportAssembly createModule];
    }
    return _supportModule;
}

- (id<BBProfileModuleInput>) profileModule {
    if (!_profileModule) {
        _profileModule = [BBProfileAssembly createModule];
    }
    return _profileModule;
}

- (id<BBBasketModuleInput>)basketModule {
    if (!_basketModule) {
        _basketModule = [BBBasketAssembly createModule];
    }
    return _basketModule;
}

@end