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

@interface BBPaymentPresenter()

@end

@implementation BBPaymentPresenter

#pragma mark - Методы BBPaymentModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBPaymentViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBPaymentInteractorOutput

@end