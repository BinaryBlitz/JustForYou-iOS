#import "BBStockPresenter.h"

#import "BBStockViewInput.h"
#import "BBStockRouterInput.h"

#import "BBNavigationModuleInput.h"

@interface BBStockPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigationModule;

@end

@implementation BBStockPresenter

#pragma mark - Методы BBStockModuleInput

- (void)configureModule {
}

- (void)pushModuleWithNavigationModule:(id)navigationModule stock:(BBStock *)stock {
  self.navigationModule = navigationModule;
  [self.view stockForUI:stock];
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBStockViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

#pragma mark - Методы BBStockInteractorOutput

@end
