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

@property (assign, nonatomic) BOOL switchBonuses;

@end

static NSString *messagePayAlert = @"Выберите карту которой хотите оплатить";

static NSString *basketIsEmpty = @"Выберите программу которую хотите купить";
static NSString *paymentSuccessfull = @"Оплата успешно произведена";
static NSString *paymentError = @"Произошла ошибка оплаты. Проверьте баланс своей карты или попробуйте позже";


@implementation BBBasketPresenter

#pragma mark - Методы BBBasketModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigationModule = module;
    return self.view;
}

- (void)paySucces {
    [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
    [self.interactor deleteAllOrderProgramsOnUser];
    [self.view presentAlertControllerWithTitle:nil message:paymentSuccessfull titleAction:@"Ок"];
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

- (void)payButtonDidTapWithBonusesEnable:(BOOL)enable countPayments:(NSInteger)count {
    if (count > 0) {
        self.switchBonuses = enable;
        [self.view createAndPresentTableAlertWithMessage:messagePayAlert];
    } else {
        [self.view presentAlertWithTitle:kNoteTitle message:basketIsEmpty];
    }
}

- (void)payNewCardButtonDidTap {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor createOrderOnServerWithTypePayment:kTypeNewPayment payCard:nil useBonuses:self.switchBonuses];
}

- (void)payCardWithCard:(BBPayCard *)card {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor createOrderOnServerWithTypePayment:kTypeCardPayment payCard:card useBonuses:self.switchBonuses];
}

- (void)removeButtonDidTapWithOrderProgram:(BBOrderProgram *)order {
    NSArray *objects = [self.interactor deleteOrderProgramOnUserArray:order];
    [self.view updateTableViewWithDelete:objects];
}

- (void)okCancelButtonDidTap {
    [self.router dissmissViewControllerWithNavigation:[self.navigationModule currentView]];
}

#pragma mark - Методы BBBasketInteractorOutput

- (void)currentOrders:(NSArray *)orders {
    [self.view updateTableViewWithOrders:orders];
}

- (void)paymentDidStartWithPayment:(BBPayment *)payment {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.paymentModule pushModuleWithNavigationModule:self.navigationModule basketModule:self payment:payment];
}

- (void)paymentSuccessfull {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.interactor deleteAllOrderProgramsOnUser];
    [self.view presentAlertControllerWithTitle:nil message:paymentSuccessfull titleAction:@"Ок"];
}

- (void)paymentError {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kErrorTitle message:paymentError];
}

- (void)errorNetwork {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}


#pragma mark - Lazy Load

- (id<BBPaymentModuleInput>)paymentModule {
    if (!_paymentModule) {
        _paymentModule = [BBPaymentAssembly createModule];
    }
    return _paymentModule;
}

@end
