//
//  BBBlocksPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksPresenter.h"

#import "BBBlocksViewInput.h"
#import "BBBlocksInteractorInput.h"
#import "BBBlocksRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBBlocksPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

@implementation BBBlocksPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

#pragma mark - Методы BBBlocksViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBBlocksInteractorOutput

@end