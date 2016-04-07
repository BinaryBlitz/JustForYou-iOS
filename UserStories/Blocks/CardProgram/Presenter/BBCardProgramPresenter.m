//
//  BBCardProgramPresenter.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramPresenter.h"

#import "BBCardProgramViewInput.h"
#import "BBCardProgramInteractorInput.h"
#import "BBCardProgramRouterInput.h"

@interface BBCardProgramPresenter()

@end

@implementation BBCardProgramPresenter

#pragma mark - Методы BBCardProgramModuleInput

- (void)configureModule {
    
}

#pragma mark - Методы BBCardProgramViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBCardProgramInteractorOutput

@end