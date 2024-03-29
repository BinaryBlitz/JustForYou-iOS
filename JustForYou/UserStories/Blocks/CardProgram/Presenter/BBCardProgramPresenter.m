#import "BBCardProgramPresenter.h"

#import "BBCardProgramViewInput.h"
#import "BBCardProgramInteractorInput.h"
#import "BBCardProgramRouterInput.h"

#import "BBNavigationAssembly.h"
#import "BBNavigationModuleInput.h"

#import "BBDeliveryAssembly.h"
#import "BBNewOrderAssembly.h"
#import "BBNewOrderModuleInput.h"

@interface BBCardProgramPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id <BBNavigationModuleInput> basketNavigationModule;

@property (nonatomic) NSInteger programId;
@property (nonatomic) BOOL clearData;
@property (strong, nonatomic) id <BBDeliveryModuleInput> deliveryModule;
@property (strong, nonatomic) id <BBNewOrderModuleInput> neworderModule;

@end

static NSString *kImageNameBasketFull = @"basketFull";
static NSString *kImageNameBasket = @"basket";

@implementation BBCardProgramPresenter

#pragma mark - Методы BBCardProgramModuleInput

- (void)configureModule {
  self.clearData = YES;
}

- (void)pushModuleWithNavigationModule:(id)navigationModule prog:(NSInteger)prog {
  self.navigModule = navigationModule;
  self.programId = prog;
  [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBCardProgramViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)viewWillAppear {
  [self.interactor checkBasket];
  [self.interactor programInDataBaseWithParentId:self.programId];
  NSArray *res = [self.interactor checkDaysInDataBaseWith:self.programId];
  if (res && [res count] > 0) {
    self.clearData = NO;
    [self.interactor listDaysWithParentId:self.programId];
  } else {
    self.clearData = YES;
//        [self.view showLoaderView];
    [self.interactor listDaysWithParentId:self.programId];
  }
}

- (void)basketButtonDidTap {
  [self.router presentBasketViewControllerWithController:[self.basketNavigationModule currentViewWithLoadModule:BBLoadBasketModule]
                                withNavigationController:[self.navigModule currentView]];
}

- (void)addToBasketButtonDidTapWithProgram:(BBProgram *)program {
  if (program.individualPrice) {
    [self.router callManagerOnPhone:kNumberPhoneManager];
  } else {
    
    [self.neworderModule pushModuleWithNavigationModule:self.navigModule program:program parentModule:self];

    //[self.view showAddInBasketPopover];
  }
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count {
  [self.view updateBasketButtonImageWithImageName:kImageNameBasketFull];
  [self.view changeImageAndPresentAlertControllerWithMessage:@"Программа успешно добавлена в корзину" cancelTitle:@"Продолжить"];
}

- (void)errorCallManager {
  [self.view presentAlertWithTitle:kErrorTitle message:kErrorCallManager];
}

#pragma mark - Методы BBCardProgramInteractorOutput

- (void)currentProgramInDataBase:(BBProgram *)program {
  if (program.programId) {
    [self.view hideLoaderView];
    [self.view updateViewWithProgram:program.programId];
  } else {
    [self.view showLoaderView];
    [self.interactor listDaysWithParentId:self.programId];
  }
}

- (void)daysSaveInDataBase {
  [self.view hideLoaderView];
  [self.interactor programInDataBaseWithParentId:self.programId];
}

- (void)errorClient {
  if (self.clearData) {
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
  }
}

- (void)errorServer {
  if (self.clearData) {
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
  }
}

- (void)currentProgramsInBasket:(NSArray *)programs {
  if ([programs count] > 0) {
    [self.view updateBasketButtonImageWithImageName:kImageNameBasketFull];
  } else {
    [self.view updateBasketButtonImageWithImageName:kImageNameBasket];
  }
}

#pragma makr - Lazy Load 

- (id <BBNavigationModuleInput>)basketNavigationModule {
  if (!_basketNavigationModule) {
    _basketNavigationModule = [BBNavigationAssembly createModule];
  }
  return _basketNavigationModule;
}

- (id <BBNewOrderModuleInput>)neworderModule {
  if (!_neworderModule) {
    _neworderModule = [BBNewOrderAssembly createModule];
  }
  return _neworderModule;
}

@end
