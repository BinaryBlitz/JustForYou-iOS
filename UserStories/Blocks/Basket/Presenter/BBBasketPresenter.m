//
//  BBBasketPresenter.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketPresenter.h"

#import "BBBasketViewInput.h"
#import "BBBasketInteractorInput.h"
#import "BBBasketRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBBasketPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

@implementation BBBasketPresenter

#pragma mark - Методы BBBasketModuleInput

- (void)configureModule {
    
}

- (void)popModuleWithNavigationModule:(id)navigationModule {
    self.navigModule = navigationModule;
    [self.router popViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBBasketViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBBasketInteractorOutput

@end