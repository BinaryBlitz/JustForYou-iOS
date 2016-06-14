//
//  BBBasketPresenter.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketPresenter.h"

#import "BBBasketViewInput.h"
#import "BBBasketInteractorInput.h"
#import "BBBasketRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBBasketPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@end

@implementation BBBasketPresenter

#pragma mark - Методы BBBasketModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigationModule = module;
    return self.view;
}


#pragma mark - Методы BBBasketViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.interactor currentOrdersInBasket];
}

- (void)closeButtonDidTap {
    [self.router dissmissViewControllerWithNavigation:[self.navigationModule currentView]];
}

- (void)payButtonDidTap {
    
}

#pragma mark - Методы BBBasketInteractorOutput

- (void)currentOrders:(NSArray *)orders {
    [self.view updateTebleViewWithOrders:orders];
}

@end
