//
//  BBReplaceProgramPresenter.m
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramPresenter.h"

#import "BBReplaceProgramViewInput.h"
#import "BBReplaceProgramInteractorInput.h"
#import "BBReplaceProgramRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBReplaceProgramPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@property (strong, nonatomic) BBPurchases *purchase;

@end

@implementation BBReplaceProgramPresenter

#pragma mark - Методы BBReplaceProgramModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule purchase:(BBPurchases *)purchase {
    self.navigationModule = navigationModule;
    self.purchase = purchase;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBReplaceProgramViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBReplaceProgramInteractorOutput

@end