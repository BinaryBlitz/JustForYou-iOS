//
//  BBOrdersPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersPresenter.h"

#import "BBOrdersViewInput.h"
#import "BBOrdersInteractorInput.h"
#import "BBOrdersRouterInput.h"

@interface BBOrdersPresenter()

@end

@implementation BBOrdersPresenter

#pragma mark - Методы BBOrdersModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBOrdersViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBOrdersInteractorOutput

@end