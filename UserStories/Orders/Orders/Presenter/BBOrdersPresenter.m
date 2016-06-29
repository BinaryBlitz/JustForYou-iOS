//
//  BBOrdersPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersPresenter.h"

#import "BBOrdersViewInput.h"
#import "BBOrdersInteractorInput.h"
#import "BBOrdersRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBMyProgramsAssembly.h"
#import "BBMyProgramsModuleInput.h"

#import "BBPaymentAssembly.h"
#import "BBPaymentModuleInput.h"

#import "BBPayment.h"

@interface BBOrdersPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id<BBMyProgramsModuleInput> myProgramModule;
@property (strong, nonatomic) id<BBPaymentModuleInput> paymentModule;

@property (assign, nonatomic) NSInteger payId;
@property (strong, nonatomic) NSString *payURL;

@end

static NSString *kPurchasesEmpty = @"Вы не можете создать новый заказ так как у вас нет купленных программ";
static NSString *kDeliveriesEmpty = @"У вас нет созданных заказов";

@implementation BBOrdersPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

- (void)popViewControllerWithStatus:(BBStatusCreateDelivery)status {
    [self.router popViewControllerWithNavigationController:[self.navigModule currentView]];
}

- (void)paySucces {
    [self.router popViewControllerWithNavigationController:[self.navigModule currentView]];
    [self.view presentAlertWithTitle:nil message:paymentSuccessfull];
}


#pragma mark - Методы BBOrdersViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.interactor listMyDeliveriesOnDataBase];
}

- (void)addNewOrderButtonDidTap {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor checkMyDeliveryInvoices];
}

- (void)payNewCardButtonDidTap {
    BBPayment *payment = [[BBPayment alloc] init];
    payment.paymentId = self.payId;
    payment.paymentURL = self.payURL;
    [self.paymentModule pushModuleWithNavigationModule:self.navigModule basketModule:self payment:payment];
}

- (void)payCardWithCard:(BBPayCard *)card {
    [self.interactor payOnServerWithPayCard:card paiId:self.payId];
}

#pragma mark - Методы BBOrdersInteractorOutput

- (void)deliveryInvoicesWithPayId:(NSInteger)payId payURL:(NSString *)url {
    self.payId = payId;
    self.payURL = url;
    [self.view createAndPresentTableAlertWithMessage:messagePayAlert];
}

- (void)deliveryInvoicesNil {
    [self.interactor listPurchasesUser];
}

- (void)currentMyDeliveriesWithArray:(NSArray *)array {
    if ([array count] == 0) {
        [self.view presentAlertWithTitle:kNoteTitle message:kDeliveriesEmpty];
    } else {
        [self.view updateDeliveriesWithArray:array];
    }
    [self.interactor myDeliveriesOnServer];
}

- (void)updateDeliveriesWithArray:(NSArray *)array {
    [self.view updateDeliveriesWithArray:array];
}

- (void)errorNetwork {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

- (void)paymentSuccessfull {
    [self.interactor listPurchasesUser];
}

- (void)paymentError {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kErrorTitle message:paymentError];
}

- (void)currentPurchasesUserWithArray:(NSArray *)array {
    [self.view hideBackgroundLoaderViewWithAlpha];
    if ([array count] > 0) {
        [self.myProgramModule pushModuleWithNavigationModule:self.navigModule parent:self purchasesArray:array];
    } else {
        [self.view presentAlertWithTitle:nil message:kPurchasesEmpty];
    }
}

#pragma  mark - Lazy Load

- (id<BBMyProgramsModuleInput>)myProgramModule {
    if (!_myProgramModule) {
        _myProgramModule = [BBMyProgramsAssembly createModule];
    }
    return _myProgramModule;
}


- (id<BBPaymentModuleInput>)paymentModule {
    if (!_paymentModule) {
        _paymentModule = [BBPaymentAssembly createModule];
    }
    return _paymentModule;
}

@end