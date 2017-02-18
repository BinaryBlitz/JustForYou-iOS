#import "BBDeliveryPresenter.h"

#import "BBDeliveryViewInput.h"
#import "BBDeliveryInteractorInput.h"
#import "BBDeliveryRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBNewOrderModuleInput.h"

#import "BBPurchases.h"

@interface BBDeliveryPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBNewOrderModuleInput> parentModule;

@property (assign, nonatomic) BBPurchases *purchase;
@property (strong, nonatomic) NSArray *selectionDays;

@end

@implementation BBDeliveryPresenter

#pragma mark - Методы BBDeliveryModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchase:(BBPurchases *)purchase daysArray:(NSArray *)days {
    self.navigationModule = navigationModule;
    self.parentModule = parent;
    self.purchase = purchase;
    self.selectionDays = days;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBDeliveryViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.view purchaseForCalendar:self.purchase selectionDates:self.selectionDays];
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
