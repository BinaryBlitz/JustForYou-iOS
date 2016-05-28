//
//  BBReplacementPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplacementPresenter.h"

#import "BBReplacementViewInput.h"
#import "BBReplacementInteractorInput.h"
#import "BBReplacementRouterInput.h"

@interface BBReplacementPresenter()

@end

@implementation BBReplacementPresenter

#pragma mark - Методы BBReplacementModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBReplacementViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBReplacementInteractorOutput

@end