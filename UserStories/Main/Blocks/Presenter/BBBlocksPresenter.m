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

@interface BBBlocksPresenter()

@end

@implementation BBBlocksPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBBlocksViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBBlocksInteractorOutput

@end