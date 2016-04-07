//
//  BBSupportPresenter.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportPresenter.h"

#import "BBSupportViewInput.h"
#import "BBSupportInteractorInput.h"
#import "BBSupportRouterInput.h"

@interface BBSupportPresenter()

@end

@implementation BBSupportPresenter

#pragma mark - Методы BBSupportModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBSupportViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBSupportInteractorOutput

@end