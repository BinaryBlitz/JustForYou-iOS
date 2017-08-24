#import "BBOrdersPresenter.h"

#import "BBOrdersViewInput.h"
#import "BBOrdersInteractorInput.h"
#import "BBOrdersRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBMyProgramsAssembly.h"
#import "BBMyProgramsModuleInput.h"

#import "BBPaymentAssembly.h"
#import "BBPaymentModuleInput.h"

#import "BBPayment.h"
#import "BBCalendarService.h"

@interface BBOrdersPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigModule;
@property (strong, nonatomic) id <BBMyProgramsModuleInput> myProgramModule;
@property (strong, nonatomic) id <BBPaymentModuleInput> paymentModule;

@property (assign, nonatomic) NSInteger payId;
@property (strong, nonatomic) NSString *payURL;

@property (assign, nonatomic) NSInteger total;
@property (assign, nonatomic) NSInteger invoicesId;

@property (strong, nonatomic) BBOrder *order;

@end

static NSString *kPurchasesEmpty = @"Отсутствуют программы, для которых не определена дата доставки. Отмените доставку, чтобы назначить новую";
static NSString *kDeliveriesEmpty = @"Вы можете распределить оставшиеся дни Вашей программы, нажав кнопку новый заказ";

static NSString *kRemoveDeliver = @"Доставка успешно отменена";

static NSString *kErrorDeleteDeliveryDay = @"Вы не можете отменить доставку на прошедший день";
static NSString *kErrorTimeRemoveDelivery = @"Вы не можете отменить доставку до которой осталось меньше 36 часов";
static NSString *kRealyRemoveDelivery = @"Вы уверены что хотите отменить доставку?";

@implementation BBOrdersPresenter

#pragma mark - Методы BBBlocksModuleInput

- (void)configureModule {
}

- (id)currentViewWithModule:(id)module {
  self.navigModule = module;
  return self.view;
}

- (void)popViewControllerWithStatus:(BBStatusCreateDelivery)status {
  [self.router popViewControllerWithNavigationController:[self.navigModule currentView]];
}

- (void)paySucces {
  [self.router popViewControllerWithNavigationController:[self.navigModule currentView]];
  [self.view presentAlertWithTitle:nil message:paymentSuccessfull];
}

#pragma mark - Методы BBOrdersViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)viewWillAppear {
  [self.router updateCountPurchasesUser];
  [self.interactor listMyDeliveriesOnDataBase];
}

- (void)addNewOrderButtonDidTap {
  [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
  [self.interactor checkMyDeliveryInvoices];
}

- (void)deleteButtonDidTapWithOrder:(BBOrder *)order {
  if ([[BBCalendarService sharedService] timeForDate:order.scheduledDay] == BBStatusPassedTime) {
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorDeleteDeliveryDay];
  } else if ([[BBCalendarService sharedService] timeForDate:order.scheduledDay] == BBstatusTodayTime) {
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorTimeRemoveDelivery];
  } else {
    self.order = order;
    [self.view presentAlertControllerWithTitle:kNoteTitle
                                       message:kRealyRemoveDelivery
                                   titleAction:@"Да"
                                   cancelTitle:@"Нет"
                                           key:kPayOkButton];
  }
}

- (void)okCancelButtonDidTapWithKey:(BBKeyForOkButtonAlert)key {
  if (key == kContinueButton) {
    [self.view createAndPresentTableAlertWithMessage:messagePayAlert];
  } else if (key == kPopController) {
    [self.router presentFirstItemOnTabbar];
  } else if (key == kPayOkButton) {
    [self.view clearOrdersArrayWithOrder:self.order];
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor deleteOrderWithOrder:self.order];
  } else {
    [self.view hideBackgroundLoaderViewWithAlpha];
  }
}

- (void)payNewCardButtonDidTap {
  BBPayCard *card = [[BBPayCard alloc] init];
  card.payCardId = -1;
  [self.interactor payDeliveriesWithTotal:self.total invoicesId:self.invoicesId card:card];
}

- (void)payCardWithCard:(BBPayCard *)card {
  [self.interactor payDeliveriesWithTotal:self.total invoicesId:self.invoicesId card:card];
}

- (void)cancelButtonDidTap {
  [self.view hideBackgroundLoaderViewWithAlpha];
}

#pragma mark - Методы BBOrdersInteractorOutput

- (void)deliveryInvoicesWithPayId:(NSInteger)payId payURL:(NSString *)url {
  self.payId = payId;
  self.payURL = url;
  BBPayment *payment = [[BBPayment alloc] init];
  payment.paymentId = payId;
  payment.paymentURL = url;
  [self.paymentModule pushModuleWithNavigationModule:self.navigModule basketModule:self payment:payment];
}

- (void)deliveryInvoicesNil {
  [self.interactor listPurchasesUser];
}

- (void)currentMyDeliveriesWithArray:(NSArray *)array {
  if ([array count] == 0) {
//        [self.view presentAlertWithTitle:kNoteTitle message:kDeliveriesEmpty];
  } else {
    [self.view updateDeliveriesWithArray:array];
  }
  [self.interactor myDeliveriesOnServer];
}

- (void)updateDeliveriesWithArray:(NSArray *)array {
  [self.view updateDeliveriesWithArray:array];
}

- (void)createPayDeliveriesWithTotal:(NSInteger)total invoicesId:(NSInteger)invoicesId {
  self.invoicesId = invoicesId;
  self.total = total;
  [self.view presentAlertControllerWithTitle:kNoteTitle
                                     message:[NSString stringWithFormat:@"Вы не можете создать новую доставку: у Вас остались неоплаченные заказы. Оплатить %ld Р", (long) total]
                                 titleAction:@"Оплатить"
                                 cancelTitle:@"Отмена"
                                         key:kContinueButton];
}

- (void)deliveriesDeleted {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.router updateCountPurchasesUser];
  [self.interactor listMyDeliveriesOnDataBase];
  [self.view presentAlertWithTitle:kNoteTitle message:kRemoveDeliver];
}

- (void)errorNetwork {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

- (void)paymentSuccessfull {
  [self.interactor listPurchasesUser];
}

- (void)paymentError {
  [self.view hideBackgroundLoaderViewWithAlpha];
  [self.view presentAlertWithTitle:kErrorTitle message:paymentError];
}

- (void)currentPurchasesUserWithArray:(NSArray *)array {
  [self.view hideBackgroundLoaderViewWithAlpha];
  if ([array count] > 0) {
    [self.myProgramModule pushModuleWithNavigationModule:self.navigModule parent:self purchasesArray:array];
  } else {
    [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"dostavkа" action:@"regected" label:@""];
//        [self.view presentAlertWithTitle:nil message:kPurchasesEmpty];
    [self.view presentAlertControllerWithTitle:nil
                                       message:kPurchasesEmpty
                                   titleAction:kNextButton
                                   cancelTitle:nil
                                           key:kPopController];
  }
}

#pragma  mark - Lazy Load

- (id <BBMyProgramsModuleInput>)myProgramModule {
  if (!_myProgramModule) {
    _myProgramModule = [BBMyProgramsAssembly createModule];
  }
  return _myProgramModule;
}

- (id <BBPaymentModuleInput>)paymentModule {
  if (!_paymentModule) {
    _paymentModule = [BBPaymentAssembly createModule];
  }
  return _paymentModule;
}

@end
