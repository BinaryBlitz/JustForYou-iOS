#import "BBListMyProgPresenter.h"

#import "BBListMyProgViewInput.h"
#import "BBListMyProgInteractorInput.h"
#import "BBListMyProgRouterInput.h"

#import "BBNavigationModuleInput.h"
#import "BBProfileModuleInput.h"

#import "BBReplaceProgramAssembly.h"
#import "BBReplaceProgramModuleInput.h"

@interface BBListMyProgPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBProfileModuleInput> parentModule;
@property (strong, nonatomic) id<BBReplaceProgramModuleInput> replaceProgramModule;

@property (strong, nonatomic) BBPurchases *purchase;

@end

@implementation BBListMyProgPresenter

#pragma mark - Методы BBListMyProgModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule {
    self.navigationModule = navigationModule;
    self.parentModule = parentModule;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBListMyProgViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.view showBackgroundLoaderViewWithAlpha:alphaBackgroundLoader];
    [self.interactor listPurchasesUser];
}

- (void)replaceButtonDidTapWithPurchase:(BBPurchases *)purchase {
    self.purchase = purchase;
    [self.replaceProgramModule pushModuleWithNavigationModule:self.navigationModule purchase:purchase];
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count programId:(NSInteger)programId {
    [self.interactor addInOrdersUserOrderWithProgramId:programId countDay:count];
    [self.view changeImageAndPresentAlertControllerWithMessage:@"Программа успешно добавлена в корзину. Для продления пройдите в корзину для оплаты" cancelTitle:kNextButton];
}

#pragma mark - Методы BBListMyProgInteractorOutput

- (void)errorNetwork {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorConnectNetwork];
}

- (void)errorServer {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view presentAlertWithTitle:kNoteTitle message:kErrorServer];
}

- (void)currentPurchasesUserWithArray:(NSArray *)array {
    [self.view hideBackgroundLoaderViewWithAlpha];
    [self.view updateTableViewWithArrayObjects:array];
}

#pragma mark - Lazy Load

- (id<BBReplaceProgramModuleInput>)replaceProgramModule {
    if (!_replaceProgramModule) {
        _replaceProgramModule = [BBReplaceProgramAssembly createModule];
    }
    return _replaceProgramModule;
}

@end
