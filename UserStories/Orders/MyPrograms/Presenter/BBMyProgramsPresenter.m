//
//  BBMyProgramsPresenter.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyProgramsPresenter.h"

#import "BBMyProgramsViewInput.h"
#import "BBMyProgramsInteractorInput.h"
#import "BBMyProgramsRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBMyProgramsPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBMyProgramsPresenter

#pragma mark - Методы BBMyProgramsModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBMyProgramsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBMyProgramsInteractorOutput

@end