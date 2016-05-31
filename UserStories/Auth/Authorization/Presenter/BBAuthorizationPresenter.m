//
//  BBAuthorizationPresenter.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAuthorizationPresenter.h"

#import "BBAuthorizationViewInput.h"
#import "BBAuthorizationInteractorInput.h"
#import "BBAuthorizationRouterInput.h"

#import "BBRegistrationAssembly.h"
#import "BBRegistrationModuleInput.h"

#import "BBNavigationModuleInput.h"

@interface BBAuthorizationPresenter()

@property (strong, nonatomic) id<BBRegistrationModuleInput> registModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

static NSString *kNoteTitle = @"Внимание";

static NSString *kErrorNumberPhoneMessage = @"Вы неверно ввели номер телефона. Пожалуйста проверьте данные и повторите попытку";
static NSString *kErrorConnectNetwork = @"Ошибка соединения. Проверьте пожалуйста подключение к интернету";
static NSString *kErrorServer = @"Ошибка данных. Проверьте пожалуйста номер телефона";

@implementation BBAuthorizationPresenter

#pragma mark - Методы BBAuthorizationModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

- (id)currentView {
    return self.view;
}

#pragma mark - Методы BBAuthorizationViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)nextButtonDidPress {
    [self.view getNumberPhoneUser];
}

- (void)backButtonDidTap {
    [self.view updateTableViewWithKeyTableView:kNumberPhoneStyleTableView];
}

- (void)numberPhoneUserWithString:(NSString *)phone {
    [self.registModule presentWithNavigModule:self.navigModule andUserPhone:phone];
}

- (void)sendCodeButtonDidTapWithValidField:(BOOL)valid andNumberPhone:(NSString *)primaryNumber {
    if (valid) {
        [self.view showIndicator];
        [self.interactor sendNumberPhoneWithPrimaryPhone:primaryNumber];
    } else {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorNumberPhoneMessage];
    }
}

#pragma mark - Методы BBAuthorizationInteractorOutput

- (void)sendCodeSuccessfullyWithAuthToken:(NSString *)token {
    [self.view hideIndicator];
    [self.view updateTableViewWithKeyTableView:kSendCodeStyleTableView];
}

- (void)noConnectionNetwork {
    [self.view hideIndicator];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideIndicator];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

#pragma mark - Lazy Load

- (id<BBRegistrationModuleInput>) registModule {
    if (!_registModule) {
        _registModule = [BBRegistrationAssembly createModule];
    }
    return _registModule;
}

@end