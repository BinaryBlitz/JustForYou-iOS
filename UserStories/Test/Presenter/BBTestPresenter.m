//
//  BBTestPresenter.m
//  JustForYou
//
//  Created by tercteberc on 19/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBTestPresenter.h"

#import "BBTestViewInput.h"
#import "BBTestInteractorInput.h"
#import "BBTestRouterInput.h"

@implementation BBTestPresenter

#pragma mark - Методы BBTestModuleInput

- (void)configureModule {

}

- (void)presentInWindow:(UIWindow *)window {
    [self.router presentFromWindow:window];
}

#pragma mark - Методы BBTestViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBTestInteractorOutput

@end