#import "BBSettingsPresenter.h"

#import "BBSettingsViewInput.h"
#import "BBSettingsInteractorInput.h"
#import "BBSettingsRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBUniversalAssembly.h"
#import "BBUniversalModuleInput.h"

@interface BBSettingsPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id <BBUniversalModuleInput> universalModule;

@end

static NSString *kErrorNumberPhoneMessage = @"Вы неверно ввели номер телефона. Пожалуйста проверьте данные и повторите попытку";

@implementation BBSettingsPresenter

#pragma mark - Методы BBSettingsModuleInput

- (void)configureModule {
}

- (void)pushModuleWithNavigationModule:(id)navigationModule {
  self.navigationModule = navigationModule;
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBSettingsViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)viewWillAppear {
  [self.view updateInfoUserWithUser:[self.interactor currentUser]];
}

- (void)viewWillDisappear {
  [self.interactor saveUser:[self.view currentInfoUser]];
}

- (void)logoutButtonDidTap {
  [self.view showLoaderView];
  [self.router popSelfViewControllerWithNavigationController:[self.navigationModule currentView]];
  [self.interactor logoutUser];
}

- (void)didSelectRowForKeyModule:(BBKeyModuleForUniversalModule)key {
  [self.universalModule pushModuleWithNavigationModule:self.navigationModule keyModule:key];
}

#pragma mark - Методы BBSettingsInteractorOutput

- (void)updateUserSuccessfully {
  [self.view hideLoaderView];
//    [self.view updateTableViewWithKeyTableView:kSendCodeStyleTableView];
}

- (void)userLogoutSuccessfully {
  [self.view hideLoaderView];
  [self.navigationModule userLogout];
}

- (void)noConnectionNetwork {
  [self.view hideLoaderView];
//    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
  [self.view hideLoaderView];
//    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

#pragma mark - Lazy Load

- (id <BBUniversalModuleInput>)universalModule {
  if (!_universalModule) {
    _universalModule = [BBUniversalAssembly createModule];
  }
  return _universalModule;
}


@end
