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

#import "BBNavigationModuleInput.h"

@interface BBUniversalPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBUniversalPresenter

#pragma mark - Методы BBUniversalModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule navigationTitle:(NSString *)title {
    self.navigationModule = navigationModule;
    [self.view navigationTitle:title];
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}


#pragma mark - Методы BBUniversalViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBUniversalInteractorOutput

@end