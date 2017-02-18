#import "BBUniversalPresenter.h"

#import "BBUniversalViewInput.h"
#import "BBUniversalInteractorInput.h"
#import "BBUniversalRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBNewOrderModuleInput.h"

#import "BBStockAssembly.h"
#import "BBStockModuleInput.h"

#import "BBAddressAssembly.h"
#import "BBAddressModuleInput.h"

@interface BBUniversalPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id <BBNewOrderModuleInput> parentNewOrderModule;
@property (strong, nonatomic) id <BBStockModuleInput> stockModule;
@property (strong, nonatomic) id <BBAddressModuleInput> addressModule;

@property (nonatomic) BBKeyModuleForUniversalModule moduleKey;

@end

@implementation BBUniversalPresenter

#pragma mark - Методы BBUniversalModuleInput

- (void)configureModule {
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule keyModule:(BBKeyModuleForUniversalModule)key {
  self.navigationModule = navigationModule;
  self.parentNewOrderModule = parentModule;
  self.moduleKey = key;
  [self _detectTitleForNavigationWithKey:key];
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)pushModuleWithNavigationModule:(id)navigationModule keyModule:(BBKeyModuleForUniversalModule)key {
  self.navigationModule = navigationModule;
  self.moduleKey = key;
  [self _detectTitleForNavigationWithKey:key];
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)_detectTitleForNavigationWithKey:(BBKeyModuleForUniversalModule)key {
  if (key == kNoneModule) {
    [self.view navigationTitle:kNameTitleNoneModule keyModule:key];
  } else if (key == kMyPayCardModule) {
    [self.view navigationTitle:kNameTitleMyPayCardModule keyModule:key];
  } else if (key == kMyProgramModule) {
    [self.view navigationTitle:kNameTitleMyProgramModule keyModule:key];
  } else if (key == kMyAddressModule) {
    [self.view navigationTitle:kNameTitleAddressModule keyModule:key];
  } else if (key == kMyHystoryPaymentModule) {
    [self.view navigationTitle:kNameTitleHystoryPaymentsModule keyModule:key];
  } else if (key == kSharesModule) {
    [self.view navigationTitle:kNameTitleSharesModule keyModule:key];
  } else if (key == kAboutModule) {
    [self.view navigationTitle:kNameTitleAboutModule keyModule:key];
  } else {
    [self.view navigationTitle:kNameTitleNoneModule keyModule:key];
  }
}

#pragma mark - Методы BBUniversalViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)cellDidSelectWithAdress:(BBAddress *)adress {
  [self.parentNewOrderModule popAdressModuleWithAdress:adress];
}

- (void)cellDidSelectWithStock:(BBStock *)stock {
  [self.stockModule pushModuleWithNavigationModule:self.navigationModule stock:stock];
}

- (void)viewWillAppear {
  [self.view settingView];
  [self.view reloadTableView];
  if (self.moduleKey == kMyAddressModule || self.moduleKey == kMyAddressForOrderModule) {
    [self.interactor currentAddressArray];
  } else if (self.moduleKey == kSharesModule) {
    [self.view showLoaderView];
    [self.interactor listShares];
  } else if (self.moduleKey == kMyPayCardModule) {
    NSArray *res = [self.interactor currentPayCards];
    if ([res count] > 0) {
      [self.view updateTableViewWithArrayObjects:res];
    } else {
      [self.view showLoaderView];
    }
    [self.interactor listPayCardsUser];
  }
}

- (void)deletedCellWithAddress:(BBAddress *)address {
  [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
  [self.interactor deleteAddress:address];
}

- (void)deletedCellWithPayCard:(BBPayCard *)card {
  [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
  [self.interactor deletePaymentCardWithCard:card];
}

- (void)addBarButtonDidTap {
  [self.addressModule pushModuleWithNavigationModule:self.navigationModule parentModule:self];
}

#pragma mark - Методы BBUniversalInteractorOutput

- (void)currentAddressArray:(NSArray *)addressArray {
  [self.view updateTableViewWithArrayObjects:addressArray];
}

- (void)currentSharesWithArray:(NSArray *)array {
  [self.view hideLoaderView];
  [self.view updateTableViewWithArrayObjects:array];
}

- (void)currentPayCardsUserWithArray:(NSArray *)array {
  [self.view hideLoaderView];
  [self.view updateTableViewWithArrayObjects:array];
}

- (void)currentAddressArrayWithDeletedAddress:(NSArray *)array {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view updateTableViewWithDeletedObjects:array];
}

- (void)currentPayCardArrayWithDeletedCard:(NSArray *)array {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view updateTableViewWithDeletedObjects:array];
}

- (void)errorNetwork {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

#pragma mark - Lazy Load

- (id <BBAddressModuleInput>)addressModule {
  if (!_addressModule) {
    _addressModule = [BBAddressAssembly createModule];
  }
  return _addressModule;
}

- (id <BBStockModuleInput>)stockModule {
  if (!_stockModule) {
    _stockModule = [BBStockAssembly createModule];
  }
  return _stockModule;
}

@end
