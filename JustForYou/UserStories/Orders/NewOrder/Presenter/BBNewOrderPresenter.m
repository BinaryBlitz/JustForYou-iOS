#import "BBNewOrderPresenter.h"

#import "BBNewOrderViewInput.h"
#import "BBNewOrderInteractorInput.h"
#import "BBNewOrderRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBDeliveryAssembly.h"
#import "BBDeliveryModuleInput.h"

#import "BBUniversalAssembly.h"
#import "BBUniversalModuleInput.h"

#import "BBMyProgramsModuleInput.h"

#import "BBProgram.h"

@interface BBNewOrderPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id <BBDeliveryModuleInput> deliveryModule;
@property (strong, nonatomic) id <BBUniversalModuleInput> universalModule;

@property (strong, nonatomic) id <BBMyProgramsModuleInput> programsModule;

@property (weak, nonatomic) BBPurchases *purchase;
@property (weak, nonatomic) BBProgram *program;
@property (weak, nonatomic) BBOrderProgram *orderProgram;
@property (strong, nonatomic) NSArray *selectionDates;
@property (strong, nonatomic) BBAddress *address;
@property (assign, nonatomic) BBStatusCreateDelivery statusServer;

@property (assign, nonatomic) BOOL deleteDays;
@property (assign, nonatomic) BOOL isConfigured;

@end

static NSString *kErrorEmptyDays = @"Вы должны выбрать хотя бы один день";
static NSString *kErrorAddress = @"Выбран некорректный адрес";

static NSString *kErrorServerDelivery = @"Произошла ошибка при создании заказа. Попробуйте повторить позже или обратитесь в службу поддержки";
static NSString *kAddBasketMessage = @"Товар добавлен в корзину";
static NSString *kDeliveryCreateMessage = @"Заказ успешно создан";

@implementation BBNewOrderPresenter

#pragma mark - Методы BBNewOrderModuleInput

- (void)configureModule {
  self.selectionDates = [NSArray array];
  self.isConfigured = NO;
  self.deleteDays = YES;
}

- (void)pushModuleWithNavigationModule:(id)navigationModule program:(BBProgram *)program parentModule:(id)parent {
  self.isConfigured = NO;
  self.statusServer = kStatusNone;
  self.navigationModule = navigationModule;
  self.program = program;
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)pushModuleWithNavigationModule:(id)navigationModule orderProgram:(BBOrderProgram *)orderProgram program:(BBProgram *)program parentModule:(id)parent {
  self.statusServer = kStatusNone;
  self.isConfigured = NO;
  self.navigationModule = navigationModule;
  self.orderProgram = orderProgram;
  self.program = program;
  self.address = orderProgram.address;
  [self selectionDates:orderProgram.days];

  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}


- (void)pushModuleWithNavigationModule:(id)navigationModule purchase:(BBPurchases *)purchase parentModule:(id)parent {
  self.isConfigured = NO;
  self.statusServer = kStatusNone;
  self.navigationModule = navigationModule;
  self.purchase = purchase;
  self.programsModule = parent;
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)popAdressModuleWithAdress:(BBAddress *)address {
  self.deleteDays = NO;
  self.address = address;
  [self.view adressForAdressTableViewCell:address.street];
  [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)selectionDates:(NSArray *)array {
  self.selectionDates = array;
  self.deleteDays = NO;
}

#pragma mark - Методы BBNewOrderViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)viewWillAppear {
  if (self.deleteDays) {
    self.selectionDates = [NSArray array];
    [self.view deleteAddress];
    self.address = nil;
  } else {
    self.deleteDays = YES;
  }
  [self.view countsDaysInCalendar:[self.selectionDates count]];
  if (self.purchase) {
    [self.view purchaseWithPurchase:self.purchase];
  } else if (self.orderProgram && !self.isConfigured) {
    self.program = [BBProgram objectsWhere:@"programId=%d", self.orderProgram.programId].firstObject;
    self.isConfigured = YES;
    [self.view orderProgramWithProgram:self.orderProgram program:self.program];
  } else {
    [self.view programWithProgram:self.program];
  }
}

- (void)countDayCellDidTap {
  [self.deliveryModule pushModuleWithNavigationModule:self.navigationModule parent:self purchase:self.purchase program:self.program   daysArray:self.selectionDates];
  self.selectionDates = [NSArray array];
}

- (void)adresCellDidTap {
  self.deleteDays = NO;
  [self.universalModule pushModuleWithNavigationModule:self.navigationModule parentModule:self keyModule:kMyAddressForOrderModule];
}

- (void)toOrderButtonDidTapWithComment:(NSString *)comment startHour:(NSInteger)hour startMinute:(NSInteger)minute {
  if ([self.selectionDates count] == 0) {
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorEmptyDays];
    return;
  }
  if (!self.address) {
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorAddress];
    return;
  }
  if (self.purchase) {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor createDeliveryOnServerWithDays:self.selectionDates address:self.address purchase:self.purchase coment:comment hour:hour minute:minute];
  } else if (self.program) {
    [self.interactor addToBasketWithProgram:self.program address:self.address days:self.selectionDates coment:comment hour:hour minute:minute];
  }
}

- (void)alertOkDidTap {
  [self _resetParametrs];
  if (self.purchase) {
    [self.programsModule popViewControllerWithStatus:self.statusServer];
  } else {
    [self.view popViewController];
  }
}

#pragma mark - Методы BBNewOrderInteractorOutput

- (void)errorNetwork {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
  [self.view hideBackgroundLoaderViewWithAlpha];
  self.statusServer = kStatusError;
  [self.view presentFinishAlertWithTitle:kNoteTitle message:kErrorServerDelivery];
}

- (void)addBasketSuccessfull {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentFinishAlertWithTitle:kNoteTitle message:kAddBasketMessage];
}

- (void)deliveriesCreateSuccessfull {
  [self.view hideBackgroundLoaderViewWithAlpha];
  self.statusServer = kStatusCreate;
  [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"dostavkа" action:@"ok" label:@""];
  [self.view presentFinishAlertWithTitle:kNoteTitle message:kDeliveryCreateMessage];
}

- (void)_resetParametrs {
  self.selectionDates = [NSArray array];
  [self.view adressForAdressTableViewCell:@""];
}

#pragma mark - Lazy Load

- (id <BBDeliveryModuleInput>)deliveryModule {
  if (!_deliveryModule) {
    _deliveryModule = [BBDeliveryAssembly createModule];
  }
  return _deliveryModule;
}

- (id <BBUniversalModuleInput>)universalModule {
  if (!_universalModule) {
    _universalModule = [BBUniversalAssembly createModule];
  }
  return _universalModule;
}


@end
