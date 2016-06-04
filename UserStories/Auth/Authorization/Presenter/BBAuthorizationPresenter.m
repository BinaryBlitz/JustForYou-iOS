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

#import "BBValidationService.h"

@interface BBAuthorizationPresenter()

@property (strong, nonatomic) id<BBRegistrationModuleInput> registModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;

@property (strong, nonatomic) NSString *authToken;
@property (strong, nonatomic) NSString *numberPhone;

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
    self.navigationModule = module;
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
    [self.view getCodeUser];
}

- (void)backButtonDidTap {
    [self.view updateTableViewWithKeyTableView:kNumberPhoneStyleTableView];
}

- (void)codeUser:(NSString *)code {
    [self.interactor sendCodeUserWithCode:code numberPhone:self.numberPhone authTiken:self.authToken];
}

- (void)sendCodeButtonDidTapWithValidField:(BOOL)valid andNumberPhone:(NSString *)primaryNumber {
    if (valid) {
        [self.view showLoaderView];
        self.numberPhone = [BBValidationService numberPhoneWithPrimaryString:primaryNumber];
        [self.interactor sendNumberPhoneWithPhone:self.numberPhone];
    } else {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorNumberPhoneMessage];
    }
}

#pragma mark - Методы BBAuthorizationInteractorOutput

- (void)sendCodeSuccessfullyWithAuthToken:(NSString *)token {
    [self.view hideLoaderView];
    self.authToken = token;
    [self.view updateTableViewWithKeyTableView:kSendCodeStyleTableView];
}

- (void)codeSuccessfullyButUserMissingOnServer {
    [self.registModule presentWithNavigModule:self.navigationModule andUserPhone:self.numberPhone authToken:self.authToken];
}

- (void)codeSuccessfullyWithUserToken:(NSString *)token {
    [self.interactor getUserOnServerAndSaveWithToken:token];
}

- (void)userSuccessfullAuthorizate {
    [self.navigationModule userRegistrationFulfilled];
}

- (void)noConnectionNetwork {
    [self.view hideLoaderView];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideLoaderView];
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