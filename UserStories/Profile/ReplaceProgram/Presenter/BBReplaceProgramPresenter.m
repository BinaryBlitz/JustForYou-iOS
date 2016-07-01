//
//  BBReplaceProgramPresenter.m
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramPresenter.h"

#import "BBReplaceProgramViewInput.h"
#import "BBReplaceProgramInteractorInput.h"
#import "BBReplaceProgramRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBPaymentAssembly.h"
#import "BBPaymentModuleInput.h"

#import "BBPayment.h"

@interface BBReplaceProgramPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBPaymentModuleInput> paymentModule;

@property (strong, nonatomic) BBPurchases *purchase;
@property (strong, nonatomic) BBProgram *program;

@property (assign, nonatomic) NSInteger payId;
@property (strong, nonatomic) NSString *payURL;
@property (strong, nonatomic) BBExchange *exchange;

@end

static NSString *kConfirmationTitle = @"Подтверждение";
static NSString *kEmptyPrograms = @"Произошла ошибка получения спика программ. Повторите позже или обратитесь в службу поддержки";

@implementation BBReplaceProgramPresenter

#pragma mark - Методы BBReplaceProgramModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule purchase:(BBPurchases *)purchase {
    self.navigationModule = navigationModule;
    self.purchase = purchase;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBReplaceProgramViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor listAllPrograms];
}

- (void)cellDidSelectRowWithProgram:(BBProgram *)program {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    self.program = program;
    [self.interactor createReplaceWithPurchase:self.purchase program:program];
}

- (void)okCancelButtonDidTapWithKey:(BBKeyForOkButtonAlert)key {
    if (key == kPopController) {
        [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
    } else if (key == kPayOkButton) {
        [self.interactor payWithExchange:self.exchange];
    } else {
        [self.view hideBackgroundLoaderViewWithAlpha];
    }
}

- (void)payNewCardButtonDidTap {
    BBPayment *payment = [[BBPayment alloc] init];
    payment.paymentId = self.payId;
    payment.paymentURL = self.payURL;
    [self.paymentModule pushModuleWithNavigationModule:self.navigationModule basketModule:self payment:payment];
}

- (void)payCardWithCard:(BBPayCard *)card {
    [self.interactor payOnServerWithPayCard:card paiId:self.payId];
}

#pragma mark - Методы BBReplaceProgramInteractorOutput

- (void)allProgramsWithArray:(NSArray *)programs {
    [self.view hideBackgroundLoaderViewWithAlpha];
    if ([programs count] > 0) {
        [self.view updateTableViewWithArray:programs];
    } else {
        [self.view presentAlertControllerWithTitle:kNoteTitle message:kEmptyPrograms titleAction:@"Ok" cancelTitle:nil key:kPopController];
    }
}

- (void)exchangeWithPayId:(NSInteger)payId payURL:(NSString *)url {
    self.payId = payId;
    self.payURL = url;
    [self.view createAndPresentTableAlertWithMessage:messagePayAlert];
}

- (void)exchangeDidCreate:(BBExchange *)exchange {
    self.exchange = exchange;
    NSString *message;
    if (exchange.pengingBalanse > 0) {
        message = [NSString stringWithFormat:@"Вам нужно дополнительно оплатить: %ld", (long)exchange.pengingBalanse];
    } else {
         message = @"Вы уверенны что хотите обменять?";
    }
    [self.view presentAlertControllerWithTitle:kConfirmationTitle message:message titleAction:@"Продолжить" cancelTitle:@"Отмена" key:kPayOkButton];
}

- (void)errorNetwork {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertControllerWithTitle:kNoteTitle message:kErrorConnectNetwork titleAction:@"Ok" cancelTitle:nil key:kPopController];
}

- (void)errorServer {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertControllerWithTitle:kNoteTitle message:kErrorServer titleAction:@"Ok" cancelTitle:nil key:kPopController];
}

- (void)paymentSuccessfull {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertControllerWithTitle:kNoteTitle message:paymentSuccessfull titleAction:@"Ok" cancelTitle:nil key:kPopController];
}

- (void)paymentError {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertControllerWithTitle:kErrorTitle message:paymentError titleAction:@"Ok" cancelTitle:nil key:kPopController];
}

#pragma  mark - Lazy Load

- (id<BBPaymentModuleInput>)paymentModule {
    if (!_paymentModule) {
        _paymentModule = [BBPaymentAssembly createModule];
    }
    return _paymentModule;
}

@end