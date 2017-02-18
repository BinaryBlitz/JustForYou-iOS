#import "BBPaymentPresenter.h"

#import "BBPaymentViewInput.h"
#import "BBPaymentInteractorInput.h"
#import "BBPaymentRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBBasketModuleInput.h"
#import "BBBasketPresenter.h"

#import "BBOrdersModuleInput.h"
#import "BBOrdersPresenter.h"

#import "BBReplaceProgramModuleInput.h"
#import "BBReplaceProgramPresenter.h"

@interface BBPaymentPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id parentModule;

@property (strong, nonatomic) BBPayment *payment;

@end

@implementation BBPaymentPresenter

#pragma mark - Методы BBPaymentModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule basketModule:(id)basketModule payment:(BBPayment *)payment {
    self.navigationModule = navigationModule;
    self.parentModule = basketModule;
    self.payment = payment;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBPaymentViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
}

- (void)viewWillAppear {
    [self.view loadWebViewWithPayment:self.payment];
}

- (void)webViewDidChangeURLWithURL:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    NSRange range = [urlString rangeOfString:@"success" options:NSLiteralSearch];
    if (range.length > 3) {
        [self popController];
    }
    range = [urlString rangeOfString:@"draft/ok" options:NSLiteralSearch];
    if (range.length > 3) {
        [self popController];
    }
}

- (void)popController {
    if ([self.parentModule isKindOfClass:[BBBasketPresenter class]]) {
        id<BBBasketModuleInput> basket = self.parentModule;
        [basket paySucces];
    } else if ([self.parentModule isKindOfClass:[BBOrdersPresenter class]]) {
        id<BBOrdersModuleInput> orders = self.parentModule;
        [orders paySucces];
    } else if ([self.parentModule isKindOfClass:[BBReplaceProgramPresenter class]]) {
        id<BBReplaceProgramModuleInput> replacement = self.parentModule;
        [replacement paySucces];
    }

}

#pragma mark - Методы BBPaymentInteractorOutput

@end
