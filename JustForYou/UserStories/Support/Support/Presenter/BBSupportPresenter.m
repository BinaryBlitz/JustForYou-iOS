//
//  BBSupportPresenter.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportPresenter.h"

#import "BBSupportViewInput.h"
#import "BBSupportInteractorInput.h"
#import "BBSupportRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBSupportPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigModule;

@end

static NSString *kErrorOpenEmail = @"В приложении \"Почта\" Вашего устройства не привязан аккаунт";

static NSString *kMailSuccessSend = @"Ваше письмо успешно отправлено";


static NSString *kURLBundleJFY = @"https://itunes.apple.com/us/app/justforyou/id1123372509?l=ru&ls=1&mt=8";

@implementation BBSupportPresenter

#pragma mark - Методы BBSupportModuleInput

- (void)configureModule {
    
}

- (id)currentViewWithModule:(id)module {
    self.navigModule = module;
    return self.view;
}

- (void)errorOpenEmailController {
    [self.view presentAlertControllerWithTitle:kErrorTitle message:kErrorOpenEmail];
}

- (void)mailControllerDissmassWithResult:(MFMailComposeResult)result {
    if (result == MFMailComposeResultSent) {
        [self.view presentAlertControllerWithTitle:@"" message:kMailSuccessSend];
    }
    
    if (result == MFMailComposeResultFailed) {
        [self.view presentAlertControllerWithTitle:@"" message:kErrorSendEmail];
    }
}

- (void)errorCallManager {
    [self.view presentAlertControllerWithTitle:kErrorTitle message:kErrorCallManager];
}


#pragma mark - Методы BBSupportViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)writeManagerButtonDidTap {
    [self.router presentMailController];
}

- (void)callManagerButtonDidTap {
    [self.router callManagerOnPhone:kNumberPhoneManager];
}

- (void)feedbackButtonDidTap {
    [self.router presentITunseWithAppUrl:kURLBundleJFY];
}

- (void)facebookButtonDidTap {
    [self.router openFacebookSocialGroup];
}

- (void)instagramButtonDidTap {
    [self.router openInstagamSocialGroup];
}

#pragma mark - Методы BBSupportInteractorOutput

@end
