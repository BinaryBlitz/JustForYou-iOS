//
//  BBNewOrderPresenter.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderPresenter.h"

#import "BBNewOrderViewInput.h"
#import "BBNewOrderInteractorInput.h"
#import "BBNewOrderRouterInput.h"

@interface BBNewOrderPresenter()

@end

@implementation BBNewOrderPresenter

#pragma mark - Методы BBNewOrderModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBNewOrderViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBNewOrderInteractorOutput

@end