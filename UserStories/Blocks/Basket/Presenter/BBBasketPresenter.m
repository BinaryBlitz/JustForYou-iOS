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

#import "BBPaymentAssembly.h"
#import "BBPaymentModuleInput.h"

@interface BBBasketPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBPaymentModuleInput> paymentModule;

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
    [self.interactor createOrderOnServer];
}

- (void)removeButtonDidTapWithOrderProgram:(BBOrderProgram *)order {
    NSArray *objects = [self.interactor deleteOrderProgramOnUserArray:order];
    [self.view updateTableViewWithDelete:objects];
}

#pragma mark - Методы BBBasketInteractorOutput

- (void)currentOrders:(NSArray *)orders {
    [self.view updateTableViewWithOrders:orders];
}

- (void)paymentDidStartWithPayment:(BBPayment *)payment {
    [self.paymentModule pushModuleWithNavigationModule:self.navigationModule payment:payment];
}


#pragma mark - Lazy Load

- (id<BBPaymentModuleInput>)paymentModule {
    if (!_paymentModule) {
        _paymentModule = [BBPaymentAssembly createModule];
    }
    return _paymentModule;
}

@end
