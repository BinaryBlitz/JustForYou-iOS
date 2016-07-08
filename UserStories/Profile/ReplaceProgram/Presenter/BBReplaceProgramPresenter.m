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
static NSString *kErrorIdentyProgram = @"Вы не можете заменять одинаковые программы";

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
    [self.interactor listAllProgramsWithProgramId:self.purchase.programId];
}

- (void)cellDidSelectRowWithProgram:(BBProgram *)program {
    if (self.purchase.programId == program.programId) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorIdentyProgram];
    } else {
        self.program = program;
        [self.view presentAlertControllerWithTitle:kConfirmationTitle message:[self _calculatePrice] titleAction:@"Продолжить" cancelTitle:@"Отмена" key:kContinueButton];
    }
}


- (NSString *)_calculatePrice {
    NSString *message;
    NSInteger old, new, result;
    if ([self _calculateThresholdWithThreshold:self.purchase.threshold]) {
        old = self.purchase.countDays * self.purchase.secondaryPrice;
    } else {
        old = self.purchase.countDays * self.purchase.primaryPrice;
    }
    if ([self _calculateThresholdWithThreshold:self.program.threshold]) {
        new = self.purchase.countDays * self.program.secondaryPrice;
    } else {
        new = self.purchase.countDays * self.program.primaryPrice;
    }
    result = new - old;
    if (result <= 0) {
        message = [NSString stringWithFormat:@"При замене на данную программу вам будет начисленно %ld бонусов", (long)result*(-1)];
    } else {
        message = [NSString stringWithFormat:@"При замене на данную программу вам нужно будет доплатить %ld P", (long)result];
    }
    return message;
}

- (BOOL)_calculateThresholdWithThreshold:(NSInteger)threshold {
    if (self.purchase.countDays >= threshold) {
        return YES;
    }
    return NO;
}

- (void)okCancelButtonDidTapWithKey:(BBKeyForOkButtonAlert)key {
    if (key == kPopController) {
        [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
    } else if (key == kContinueButton) {
        [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
        [self.interactor createReplaceWithPurchase:self.purchase program:self.program];
    } else if (key == kPayOkButton) {
    
    } else {
        [self.view hideBackgroundLoaderViewWithAlpha];
    }
}

- (void)payNewCardButtonDidTap {
    BBPayCard *card = [[BBPayCard alloc] init];
    card.payCardId = -1;
    [self.interactor payWithExchange:self.exchange card:card];
}

- (void)payCardWithCard:(BBPayCard *)card {
    [self.interactor payWithExchange:self.exchange card:card];
}

- (void)cancelButtonDidTap {
    [self.view hideBackgroundLoaderViewWithAlpha];
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
    BBPayment *payment = [[BBPayment alloc] init];
    payment.paymentId = payId;
    payment.paymentURL = url;
    [self.paymentModule pushModuleWithNavigationModule:self.navigationModule basketModule:self payment:payment];

}

- (void)exchangeDidCreate:(BBExchange *)exchange {
    self.exchange = exchange;
    NSString *message;
    if (exchange.paid) {
        message = [NSString stringWithFormat:@"Замена успешно произведена. Вам начисленно бонусов %ld", (long)exchange.pengingBalanse];
        [self.view presentAlertControllerWithTitle:kNoteTitle message:message titleAction:@"Ok" cancelTitle:nil key:kPopController];
    } else {
        [self.view createAndPresentTableAlertWithMessage:messagePayAlert];
    }
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