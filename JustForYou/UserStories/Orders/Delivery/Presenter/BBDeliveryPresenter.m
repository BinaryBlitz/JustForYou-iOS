#import "BBDeliveryPresenter.h"

#import "BBDeliveryViewInput.h"
#import "BBDeliveryRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBNewOrderModuleInput.h"

@interface BBDeliveryPresenter ()

@property (strong, nonatomic) id <BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id <BBNewOrderModuleInput> parentModule;

@property (assign, nonatomic) BBPurchases *purchase;
@property (assign, nonatomic) BBProgram *program;
@property (strong, nonatomic) NSArray *selectionDays;

@end

@implementation BBDeliveryPresenter

#pragma mark - Методы BBDeliveryModuleInput

- (void)configureModule {
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchase:(BBPurchases *)purchase program:(BBProgram *)program daysArray:(NSArray *)days {
  self.navigationModule = navigationModule;
  self.parentModule = parent;
  self.program = program;
  self.purchase = purchase;
  self.selectionDays = days;
  [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBDeliveryViewOutput

- (void)didTriggerViewReadyEvent {
  [self.view setupInitialState];
}

- (void)viewWillAppear {
  [self.view purchaseForCalendar:self.purchase program:self.program selectionDates:self.selectionDays];
}

- (void)viewWillDisappear {
  [self saveDates];
}

- (void)readyButtonDidTap {
//    [self saveDates];
  [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)saveDates {
  NSArray *dates = [self.view currentSelectionDates];
  [self.parentModule selectionDates:dates];
}

#pragma mark - Методы BBDeliveryInteractorOutput

@end
