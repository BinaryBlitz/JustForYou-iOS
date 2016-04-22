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

#import "BBNavigationModuleInput.h"

@interface BBSupportPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

@implementation BBSupportPresenter

#pragma mark - Методы BBSupportModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

#pragma mark - Методы BBSupportViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBSupportInteractorOutput

@end