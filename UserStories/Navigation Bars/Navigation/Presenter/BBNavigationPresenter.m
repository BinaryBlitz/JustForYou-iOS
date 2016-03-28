//
//  BBNavigationPresenter.m
//  JustForYou
//
//  Created by tercteberc on 24/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNavigationPresenter.h"

#import "BBNavigationViewInput.h"
#import "BBNavigationInteractorInput.h"
#import "BBNavigationRouterInput.h"

@implementation BBNavigationPresenter

#pragma mark - Методы BBNavigationModuleInput

- (void)configureModule {
    
}

- (id)currentView {
    return self.view;
}

#pragma mark - Методы BBNavigationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBNavigationInteractorOutput

@end