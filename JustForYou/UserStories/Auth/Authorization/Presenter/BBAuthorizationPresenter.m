#import "BBAuthorizationPresenter.h"

#import "BBAuthorizationViewInput.h"
#import "BBAuthorizationInteractorInput.h"
#import "BBAuthorizationRouterInput.h"

#import "BBRegistrationAssembly.h"
#import "BBRegistrationModuleInput.h"

#import "BBNavigationModuleInput.h"

#import "BBGreetingAssembly.h"
#import "BBGreetingModuleInput.h"

#import "BBValidationService.h"

@interface BBAuthorizationPresenter()

@property (strong, nonatomic) id<BBRegistrationModuleInput> registModule;
@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBGreetingModuleInput> greetingModule;

@property (strong, nonatomic) NSString *authToken;
@property (strong, nonatomic) NSString *numberPhone;
@property (assign, nonatomic) BOOL validCodeInServer;

@end



static NSString *kErrorNumberPhoneMessage = @"Вы неверно ввели номер телефона. Пожалуйста проверьте данные и повторите попытку";
static NSString *kSendAgainCode = @"Код выслан вам повторно";
static NSString *kOldCodeEnter = @"Введеный вами код устарел. Пожалуйста дождитесь нового кода";
static NSString *kErrorData = @"Ошибка данных. Проверьте пожалуйста номер телефона";

@implementation BBAuthorizationPresenter

#pragma mark - Методы BBAuthorizationModuleInput

- (void)configureModule {
    self.validCodeInServer = YES;
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

- (void)viewWillAppear {
    [self.view keyForTableView:kNumberPhoneStyleTableView];
}

- (void)nextButtonDidPress {
    [self.view getCodeUser];
}

- (void)backButtonDidTap {
    [self.view updateTableViewWithKeyTableView:kNumberPhoneStyleTableView];
}

- (void)codeUser:(NSString *)code {
    if (self.validCodeInServer == NO) {
        [self.view presentAlertWithTitle:kNoteTitle message:kOldCodeEnter];
        return;
    }
    [self.view showLoaderView];
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

- (void)sengAgainButtonDidTap {
    self.validCodeInServer = NO;
    [self.view showLoaderView];
    [self.interactor sendNumberPhoneWithPhone:self.numberPhone];
    [self.view presentAlertWithTitle:@"" message:kSendAgainCode];
}

#pragma mark - Методы BBAuthorizationInteractorOutput

- (void)sendCodeSuccessfullyWithAuthToken:(NSString *)token {
    [self.view hideLoaderView];
    self.authToken = token;
    self.validCodeInServer = YES;
    [self.view updateTableViewWithKeyTableView:kSendCodeStyleTableView];
}

- (void)codeSuccessfullyButUserMissingOnServer {
    [self.view hideLoaderView];
    [self.registModule presentWithNavigModule:self.navigationModule andUserPhone:self.numberPhone authToken:self.authToken];
}

- (void)codeSuccessfullyWithUserToken:(NSString *)token {
    [self.interactor getUserOnServerAndSaveWithToken:token];
}

- (void)userSuccessfullAuthorizate {
    [self.view hideLoaderView];
    [self.greetingModule pushModuleWithNavigationModule:self.navigationModule];
}

- (void)noConnectionNetwork {
    [self.view hideLoaderView];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideLoaderView];
    self.validCodeInServer = YES;
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorData];
}

#pragma mark - Lazy Load

- (id<BBRegistrationModuleInput>) registModule {
    if (!_registModule) {
        _registModule = [BBRegistrationAssembly createModule];
    }
    return _registModule;
}

- (id<BBGreetingModuleInput>)greetingModule {
    if (!_greetingModule) {
        _greetingModule = [BBGreetingAssembly createModule];
    }
    return _greetingModule;
}

@end
