//
//  BBUniversalPresenter.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalPresenter.h"

#import "BBUniversalViewInput.h"
#import "BBUniversalInteractorInput.h"
#import "BBUniversalRouterInput.h"

@interface BBUniversalPresenter()

@end

@implementation BBUniversalPresenter

#pragma mark - Методы BBUniversalModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBUniversalViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBUniversalInteractorOutput

@end