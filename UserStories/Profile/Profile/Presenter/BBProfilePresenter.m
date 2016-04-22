//
//  BBProfilePresenter.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfilePresenter.h"

#import "BBProfileViewInput.h"
#import "BBProfileInteractorInput.h"
#import "BBProfileRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBProfilePresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

@implementation BBProfilePresenter

#pragma mark - Методы BBProfileModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

#pragma mark - Методы BBProfileViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBProfileInteractorOutput

@end