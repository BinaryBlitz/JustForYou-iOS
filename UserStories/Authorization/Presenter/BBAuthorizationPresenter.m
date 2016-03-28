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

@implementation BBAuthorizationPresenter

#pragma mark - Методы BBAuthorizationModuleInput

- (void)configureModule {
    
}

- (void)presentInWindow:(UIWindow *)window {
    [self.router presentFromWindow:window];
}


#pragma mark - Методы BBAuthorizationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBAuthorizationInteractorOutput

@end