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

@interface BBRegistrationPresenter()


@end

@implementation BBRegistrationPresenter

#pragma mark - Методы BBRegistrationModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBRegistrationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBRegistrationInteractorOutput

@end