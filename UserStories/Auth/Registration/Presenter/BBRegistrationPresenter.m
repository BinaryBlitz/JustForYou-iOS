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

@interface BBRegistrationPresenter()

@property (weak, nonatomic) id<BBAuthorizationModuleInput> authModule;

@end

@implementation BBRegistrationPresenter

#pragma mark - Методы BBRegistrationModuleInput

- (void)configureModule {
    
}

- (void)presentWithView:(id)viewController {
    
}

#pragma mark - Методы BBRegistrationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBRegistrationInteractorOutput

@end