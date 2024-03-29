#import "BBProgramsPresenter.h"

#import "BBProgramsViewInput.h"
#import "BBProgramsInteractorInput.h"
#import "BBProgramsRouterInput.h"

#import "BBNavigationAssembly.h"
#import "BBNavigationModuleInput.h"

#import "BBCardProgramAssembly.h"
#import "BBCardProgramModuleInput.h"

#import "BBNewOrderAssembly.h"
#import "BBNewOrderModuleInput.h"

@interface BBProgramsPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id <BBCardProgramModuleInput> cardProgramModule;
@property (strong, nonatomic) id <BBNavigationModuleInput> basketNavigationModule;
@property (strong, nonatomic) id <BBNewOrderModuleInput> neworderModule;

@property (nonatomic) NSInteger parentId;
@property (nonatomic) BOOL clearData;
@property (nonatomic) BOOL dataLoaded;

@end

static NSString *kImageNameBasketFull = @"basketFull";
static NSString *kImageNameBasket = @"basket";

static NSString *kErrorOpenProgram = @"Произошла ошибка при открытии программы. Попробуйте еще раз";

@implementation BBProgramsPresenter

- (void)updateData {
  if (!self.dataLoaded) {
    return;
  }
  NSArray *res = [self.interactor checkProgramsInDataBaseWith:self.parentId];
  if (res && [res count] > 0) {
    self.clearData = NO;
    [self.view programsForTableView:res];
    [self.interactor listProgramsWithParentId:self.parentId];
  } else {
    self.clearData = YES;
    [self.view showBackgroundLoaderView];
    [self.interactor listProgramsWithParentId:self.parentId];
  }
}

#pragma mark - Методы BBProgramsModuleInput

- (void)configureModule {
  self.clearData = YES;
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentId:(NSInteger)parentId {
  self.navigModule = navigationModule;
  self.parentId = parentId;
  self.dataLoaded = NO;
  [self.router pushViewControllerWithNavigationController:[self.navigModule currentView]];
}

#pragma mark - Методы BBProgramsViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)viewWillAppear {
  [self.interactor checkBasket];
  if (!self.dataLoaded) {
    self.dataLoaded = YES;
    [self updateData];
  }
}

- (void)programDidTapWithProgram:(NSInteger)programId {
  [self.cardProgramModule pushModuleWithNavigationModule:self.navigModule prog:programId];
}

- (void)errorOpenProgram {
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorOpenProgram];
}

- (void)errorCallManager {
  [self.view presentAlertWithTitle:kErrorTitle message:kErrorCallManager];
}

- (void)addToBasketButtonDidTapWithProgram:(BBProgram *)program {
  if (program.individualPrice) {
    [self.router callManagerOnPhone:kNumberPhoneManager];
  } else {
    [self.neworderModule pushModuleWithNavigationModule:self.navigModule program:program parentModule:self];
  }
}

- (void)basketButtonDidTap {
  [self.router presentBasketViewControllerWithController:[self.basketNavigationModule currentViewWithLoadModule:BBLoadBasketModule]
                                withNavigationController:[self.navigModule currentView]];
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count program:(BBProgram *)program {
  [self.view updateBasketButtonImageWithImageName:kImageNameBasketFull];
  [self.view changeImageAndPresentAlertControllerWithMessage:@"Программа успешно добавлена в корзину" cancelTitle:@"Продолжить"];
}

#pragma mark - Методы BBProgramsInteractorOutput

- (void)currentProgramsInDataBase:(NSArray *)programs {
  if ([programs count] > 0) {
    [self.view hideBackgroundLoaderView];
    [self.view programsForTableView:programs];
  } else {
    [self.view showBackgroundLoaderView];
    [self.interactor listProgramsWithParentId:self.parentId];
  }
}

- (void)programsSaveInDataBase {
  [self.view hideBackgroundLoaderView];
  [self.interactor programsInDataBaseWithParentId:self.parentId];
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

#pragma mark - Lazy Load

- (id <BBCardProgramModuleInput>)cardProgramModule {
  if (!_cardProgramModule) {
    _cardProgramModule = [BBCardProgramAssembly createModule];
  }
  return _cardProgramModule;
}

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
