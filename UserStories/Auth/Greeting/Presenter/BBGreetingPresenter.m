//
//  BBGreetingPresenter.m
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBGreetingPresenter.h"

#import "BBGreetingViewInput.h"
#import "BBGreetingInteractorInput.h"
#import "BBGreetingRouterInput.h"

@interface BBGreetingPresenter()

@end

@implementation BBGreetingPresenter

#pragma mark - Методы BBGreetingModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBGreetingViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBGreetingInteractorOutput

@end