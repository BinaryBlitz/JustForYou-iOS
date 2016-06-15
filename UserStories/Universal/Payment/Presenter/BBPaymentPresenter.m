//
//  BBPaymentPresenter.m
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBPaymentPresenter.h"

#import "BBPaymentViewInput.h"
#import "BBPaymentInteractorInput.h"
#import "BBPaymentRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBPaymentPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@property (strong, nonatomic) BBPayment *payment;

@end

@implementation BBPaymentPresenter

#pragma mark - Методы BBPaymentModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule payment:(BBPayment *)payment {
    self.navigationModule = navigationModule;
    self.payment = payment;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBPaymentViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    [self.view loadWebViewWithPayment:self.payment];
}

#pragma mark - Методы BBPaymentInteractorOutput

@end
