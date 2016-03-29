//
//  BBRegistrationPresenter.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationPresenter.h"

#import "BBRegistrationViewInput.h"
#import "BBRegistrationInteractorInput.h"
#import "BBRegistrationRouterInput.h"

#import "BBAuthorizationModuleInput.h"

#import "BBNavigationModuleInput.h"

@interface BBRegistrationPresenter()

@property (weak, nonatomic) id<BBAuthorizationModuleInput> authModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

@implementation BBRegistrationPresenter

#pragma mark - Методы BBRegistrationModuleInput

- (void)configureModule {
    
}

- (void)presentWithAuthModule:(id)module andNavigModule:(id)navigModule {
    self.authModule = module;
    self.navigModule = navigModule;
    [self.router presentFromView:self.view withNavigationView:[self.navigModule currentViewWithLoadModule:BBRegistrationModule]];
}

#pragma mark - Методы BBRegistrationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBRegistrationInteractorOutput

@end