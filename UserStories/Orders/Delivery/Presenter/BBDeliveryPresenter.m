//
//  BBDeliveryPresenter.m
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBDeliveryPresenter.h"

#import "BBDeliveryViewInput.h"
#import "BBDeliveryInteractorInput.h"
#import "BBDeliveryRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBDeliveryPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBDeliveryPresenter

#pragma mark - Методы BBDeliveryModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBDeliveryViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBDeliveryInteractorOutput

@end