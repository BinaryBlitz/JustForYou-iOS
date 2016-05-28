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

#import "BBNavigationModuleInput.h"

@interface BBReplacementPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBReplacementPresenter

#pragma mark - Методы BBReplacementModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBReplacementViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBReplacementInteractorOutput

@end