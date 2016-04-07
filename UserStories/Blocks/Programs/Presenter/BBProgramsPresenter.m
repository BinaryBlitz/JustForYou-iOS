//
//  BBProgramsPresenter.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsPresenter.h"

#import "BBProgramsViewInput.h"
#import "BBProgramsInteractorInput.h"
#import "BBProgramsRouterInput.h"

@interface BBProgramsPresenter()

@end

@implementation BBProgramsPresenter

#pragma mark - Методы BBProgramsModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBProgramsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBProgramsInteractorOutput

@end