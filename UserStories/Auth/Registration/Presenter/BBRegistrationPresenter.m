//
//  BBRegistrationPresenter.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

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

@end

static NSString *kNoteTitle = @"Внимание";

static NSString *kErrorName = @"Введите Ваше имя";
static NSString *kErrorSurname = @"Введите Вашу фамилию";
static NSString *kErrorEmail = @"Введите Ваш E-mail";
static NSString *kErrorValidEmail = @"Вы неверно ввели email. Пожалуйста проверьте данные и повторите попытку";

static NSString *kErrorConnectNetwork = @"Ошибка соединения. Проверьте пожалуйста подключение к интернету";
static NSString *kErrorServer = @"Ошибка сервера. Попробуйте снова";

@implementation BBRegistrationPresenter

#pragma mark - Методы BBRegistrationModuleInput

- (void)configureModule {
    
}

- (void)presentWithNavigModule:(id)navigModule andUserPhone:(NSString *)phone {
    self.navigModule = navigModule;
    self.userPhone = phone;
    [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
//    [self.router presentFromView:self.view withNavigationView:[self.navigModule currentViewWithLoadModule:BBRegistrationModule]];
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