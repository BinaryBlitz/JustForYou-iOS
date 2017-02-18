#import "BBRegistrationPresenter.h"

#import "BBRegistrationViewInput.h"
#import "BBRegistrationInteractorInput.h"
#import "BBRegistrationRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBGreetingAssembly.h"
#import "BBGreetingModuleInput.h"

#import "BBValidationService.h"

@class BBUser;
@interface BBRegistrationPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id<BBGreetingModuleInput> greetingModule;

@property (strong, nonatomic) NSString *userPhone;
@property (strong, nonatomic) NSString *authToken;

@end

static NSString *kErrorName = @"Введите Ваше имя";
static NSString *kErrorSurname = @"Введите Вашу фамилию";
static NSString *kErrorEmail = @"Введите Ваш E-mail";
static NSString *kErrorValidEmail = @"Вы неверно ввели email. Пожалуйста проверьте данные и повторите попытку";


@implementation BBRegistrationPresenter

#pragma mark - Методы BBRegistrationModuleInput

- (void)configureModule {
    
}

- (void)presentWithNavigModule:(id)navigModule andUserPhone:(NSString *)phone authToken:(NSString *)authToken {
    self.navigModule = navigModule;
    self.userPhone = phone;
    self.authToken = authToken;
    [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBRegistrationViewOutput

- (void)didTriggerViewReadyEvent {
    [self.view setupInitialState];
}

- (void)nextButtonDidTap {
    BBUser *user = [self.view userWithTextFields];
    if ([user.name isEqualToString:@""] || !user.name || [user.name isEqualToString:@" "]) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorName];
        return;
    }
    if ([user.surname isEqualToString:@""] || !user.surname || [user.surname isEqualToString:@" "]) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorSurname];
        return;
    }
    if ([user.email isEqualToString:@""] || !user.email || [user.email isEqualToString:@" "]) {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorEmail];
        return;
    }
    if ([BBValidationService validationEmailWithString:user.email]) {
        user.numberPhone = self.userPhone;
        [self.view showLoaderView];
        [self.view endEditingTextFields];
        [self.interactor saveAndSendUser:user];
    } else {
        [self.view presentAlertWithTitle:kNoteTitle message:kErrorValidEmail];
    }
}

#pragma mark - Методы BBRegistrationInteractorOutput

- (void)userSuccessfullySaved {
    [self.view hideLoaderView];
    [self.greetingModule pushModuleWithNavigationModule:self.navigModule];
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

- (id<BBGreetingModuleInput>)greetingModule {
    if (!_greetingModule) {
        _greetingModule = [BBGreetingAssembly createModule];
    }
    return _greetingModule;
}

@end
