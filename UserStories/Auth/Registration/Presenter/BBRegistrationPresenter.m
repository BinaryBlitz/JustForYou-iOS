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

@class BBUser;
@interface BBRegistrationPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id<BBGreetingModuleInput> greetingModule;

@property (strong, nonatomic) NSString *userPhone;

@end

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
        [self.view presentAlertControllerWithMessage:@"Введите Ваше имя"];
        return;
    }
    if ([user.surname isEqualToString:@""] || !user.surname || [user.surname isEqualToString:@" "]) {
        [self.view presentAlertControllerWithMessage:@"Введите Вашу фамилию"];
        return;
    }
    if ([user.email isEqualToString:@""] || !user.email || [user.email isEqualToString:@" "]) {
        [self.view presentAlertControllerWithMessage:@"Введите Ваш E-mail"];
        return;
    }
    user.numberPhone = self.userPhone;
    [self.interactor saveUser:user];
}

#pragma mark - Методы BBRegistrationInteractorOutput

- (void)userSuccessfullySaved {
    [self.greetingModule pushModuleWithNavigationModule:self.navigModule];
}

#pragma mark - Lazy Load

- (id<BBGreetingModuleInput>)greetingModule {
    if (!_greetingModule) {
        _greetingModule = [BBGreetingAssembly createModule];
    }
    return _greetingModule;
}

@end