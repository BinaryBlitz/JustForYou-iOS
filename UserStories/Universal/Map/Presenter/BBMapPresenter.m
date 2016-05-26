//
//  BBMapPresenter.m
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapPresenter.h"

#import "BBMapViewInput.h"
#import "BBMapInteractorInput.h"
#import "BBMapRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBMapPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBMapPresenter

#pragma mark - Методы BBMapModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBMapViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBMapInteractorOutput

@end