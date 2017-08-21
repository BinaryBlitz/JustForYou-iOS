#import "BBBasketPresenter.h"

#import "BBBasketViewInput.h"
#import "BBBasketInteractorInput.h"
#import "BBBasketRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBPaymentAssembly.h"
#import "BBPaymentModuleInput.h"

#import "BBNewOrderAssembly.h"
#import "BBNewOrderModuleInput.h";

#import "BBUserService.h";

@interface BBBasketPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id <BBPaymentModuleInput> paymentModule;
@property (strong, nonatomic) id <BBNewOrderModuleInput> neworderModule;

@property (assign, nonatomic) BOOL switchBonuses;
@property (assign, nonatomic) BOOL switchTap;

@end

static NSString *basketIsEmpty = @"Выберите программу которую хотите купить";

static NSString *basketAlertDelivery = @"Доставка осуществляется только в пределах Москвы и Московской области";

@implementation BBBasketPresenter

#pragma mark - Методы BBBasketModuleInput

- (void)configureModule {
}

- (id)currentViewWithModule:(id)module {
  self.navigationModule = module;
  return self.view;
}

- (void)paySucces {
  [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
  [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
  BBUser *user = [[BBUserService sharedService] currentUser];
  NSArray* orders = user.ordersProgramArray;
  [self.interactor createDeliveriesFromOrders:orders];
}


#pragma mark - Методы BBBasketViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)didSelectRowWithOrderProgram:(BBOrderProgram*)orderProgram {
  BBProgram *program = [BBProgram objectsWhere:@"programId=%d", orderProgram.programId].firstObject;
  [self.neworderModule pushModuleWithNavigationModule:self.navigationModule orderProgram:orderProgram program:program parentModule:self];
}

- (void)viewWillAppear {
  [self.view presentNoteAlertWithTitle:kNoteTitle message:basketAlertDelivery];
  [self.interactor currentOrdersInBasket];
}

- (void)closeButtonDidTap {
  [self.router dissmissViewControllerWithNavigation:[self.navigationModule currentView]];
}

- (void)changeStateWithState:(BOOL)state {
  if (state) {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    self.switchTap = YES;
    [self.interactor updateUserAndShowCurrentBonuses];
  } else {
    [self.view updateTotalTableViewCell];
  }
}

- (void)payButtonDidTapWithCount:(NSInteger)count {
  if (count > 0) {
    [self.view createAndPresentTableAlertWithMessage:messagePayAlert];
  } else {
    [self.view presentAlertWithTitle:kNoteTitle message:basketIsEmpty];
  }
}

- (void)payNewCardButtonDidTap {
  [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
  [self.interactor createOrderOnServerWithTypePayment:kTypeNewPayment payCard:nil useBonuses:self.switchBonuses];
}

- (void)payCardWithCard:(BBPayCard *)card {
  [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
  [self.interactor createOrderOnServerWithTypePayment:kTypeCardPayment payCard:card useBonuses:self.switchBonuses];
}

- (void)cancelButtonDidTap {
  [self.view hideBackgroundLoaderViewWithAlpha];
}

- (void)removeButtonDidTapWithOrderProgram:(BBOrderProgram *)order {
  NSArray *objects = [self.interactor deleteOrderProgramOnUserArray:order];
  [self.view updateTableViewWithDelete:objects];
}

- (void)okCancelButtonDidTap {
  [self.router dissmissViewControllerWithNavigation:[self.navigationModule currentView]];
}

#pragma mark - Методы BBBasketInteractorOutput

- (void)currentOrders:(NSArray *)orders {
  [self.view updateTableViewWithOrders:orders];
}

- (void)bonusesUpdate {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view updateTotalTableViewCell];
}

- (void)paymentDidStartWithPayment:(BBPayment *)payment {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.paymentModule pushModuleWithNavigationModule:self.navigationModule basketModule:self payment:payment];
}

- (void)paymentSuccessfull {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.interactor deleteAllOrderProgramsOnUser];
  [self.router updateCountPurchasesUser];
  [self.view presentAlertControllerWithTitle:nil message:paymentSuccessfull titleAction:kNextButton];
}

- (void)paymentError {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kErrorTitle message:paymentError];
}

- (void)errorNetwork {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self _changeSwitch];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self _changeSwitch];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

- (void)_changeSwitch {
  if (self.switchTap) {
    self.switchTap = NO;
  }
}

#pragma mark - Lazy Load

- (id <BBPaymentModuleInput>)paymentModule {
  if (!_paymentModule) {
    _paymentModule = [BBPaymentAssembly createModule];
  }
  return _paymentModule;
}

- (id <BBNewOrderModuleInput>)neworderModule {
  if (!_neworderModule) {
    _neworderModule = [BBNewOrderAssembly createModule];
  }
  return _neworderModule;
}

@end
