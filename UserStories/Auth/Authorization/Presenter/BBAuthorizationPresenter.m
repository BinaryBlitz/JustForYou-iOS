//
//  BBAuthorizationPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAuthorizationPresenter.h"

#import "BBAuthorizationViewInput.h"
#import "BBAuthorizationInteractorInput.h"
#import "BBAuthorizationRouterInput.h"

#import "BBRegistrationAssembly.h"
#import "BBRegistrationModuleInput.h"

#import "BBNavigationModuleInput.h"

@interface BBAuthorizationPresenter()

@property (strong, nonatomic) id<BBRegistrationModuleInput> registModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

@implementation BBAuthorizationPresenter

#pragma mark - Методы BBAuthorizationModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

- (id)currentView {
    return self.view;
}

#pragma mark - Методы BBAuthorizationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)nextButtonDidPress {
    [self.registModule presentWithAuthModule:self andNavigModule:self.navigModule];
}

- (void)sendAgainButtonDidPress {
    
}

#pragma mark - Методы BBAuthorizationInteractorOutput


#pragma mark - Lazy Load

- (id<BBRegistrationModuleInput>) registModule {
    if (!_registModule) {
        _registModule = [BBRegistrationAssembly createModule];
    }
    return _registModule;
}

@end