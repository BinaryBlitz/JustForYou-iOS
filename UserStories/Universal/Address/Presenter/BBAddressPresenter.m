//
//  BBAddressPresenter.m
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAddressPresenter.h"

#import "BBAddressViewInput.h"
#import "BBAddressInteractorInput.h"
#import "BBAddressRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBMapAssembly.h"
#import "BBMapModuleInput.h"

@interface BBAddressPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBAddressPresenter

#pragma mark - Методы BBAddressModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parent {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBAddressViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    
}

#pragma mark - Методы BBAddressInteractorOutput

@end