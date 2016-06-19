//
//  BBStockPresenter.m
//  JustForYou
//
//  Created by tercteberc on 19/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBStockPresenter.h"

#import "BBStockViewInput.h"
#import "BBStockInteractorInput.h"
#import "BBStockRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBStockPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBStockPresenter

#pragma mark - Методы BBStockModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
    self.navigationModule = navigationModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}


#pragma mark - Методы BBStockViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

#pragma mark - Методы BBStockInteractorOutput

@end