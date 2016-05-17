//
//  BBGreetingPresenter.m
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBGreetingPresenter.h"

#import "BBGreetingViewInput.h"
#import "BBGreetingInteractorInput.h"
#import "BBGreetingRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBGreetingPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

static NSInteger countPage = 3;

@implementation BBGreetingPresenter

#pragma mark - Методы BBGreetingModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBGreetingViewOutput

- (void)didTriggerViewReadyEvent {
    [self.view countPageInPageControl:countPage];
	[self.view setupInitialState];
}

- (void)nextButtonDidTapWithPage:(NSInteger)page {
    if (page < (countPage - 1)) {
        [self.view changePageInScrollView];
    } else {
        [self.navigationModule userRegistrationFulfilled];
    }
}

#pragma mark - Методы BBGreetingInteractorOutput

@end