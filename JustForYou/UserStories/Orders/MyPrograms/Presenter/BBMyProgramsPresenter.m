#import "BBMyProgramsPresenter.h"

#import "BBMyProgramsViewInput.h"
#import "BBMyProgramsInteractorInput.h"
#import "BBMyProgramsRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBNewOrderAssembly.h"
#import "BBNewOrderModuleInput.h"

#import "BBOrdersModuleInput.h"

@interface BBMyProgramsPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBNewOrderModuleInput> neworderModule;

@property (strong, nonatomic) id<BBOrdersModuleInput> parentModule;

@property (strong, nonatomic) NSArray *purchasesArray;

@end

@implementation BBMyProgramsPresenter

#pragma mark - Методы BBMyProgramsModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchasesArray:(NSArray *)purchases {
    self.navigationModule = navigationModule;
    self.purchasesArray = purchases;
    self.parentModule = parent;
    [self.view purchasesWithArray:purchases];
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

- (void)popViewControllerWithStatus:(BBStatusCreateDelivery)status {
    [self.router popViewControllerWithNavigationController:[self.navigationModule currentView]];
    [self.parentModule popViewControllerWithStatus:status];
}

#pragma mark - Методы BBMyProgramsViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.view reloadTableView];
}

- (void)didSelectRowWithPurchase:(BBPurchases *)purchase {
    [self.neworderModule pushModuleWithNavigationModule:self.navigationModule purchase:purchase parentModule:self];
}

#pragma mark - Методы BBMyProgramsInteractorOutput

- (void)errorNetwork {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)currentPurchasesUserWithArray:(NSArray *)array {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view purchasesWithArray:array];
    [self.view reloadTableView];
}

#pragma  mark - Lazy Load

- (id<BBNewOrderModuleInput>)neworderModule {
    if (!_neworderModule) {
        _neworderModule = [BBNewOrderAssembly createModule];
    }
    return _neworderModule;
}

@end
