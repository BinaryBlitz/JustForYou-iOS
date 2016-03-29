//
//  BBProfilePresenter.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfilePresenter.h"

#import "BBProfileViewInput.h"
#import "BBProfileInteractorInput.h"
#import "BBProfileRouterInput.h"

@interface BBProfilePresenter()

@end

@implementation BBProfilePresenter

#pragma mark - Методы BBProfileModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBProfileViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBProfileInteractorOutput

@end