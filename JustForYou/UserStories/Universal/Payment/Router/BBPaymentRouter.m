#import "BBPaymentRouter.h"

@implementation BBPaymentRouter

#pragma mark - BBPaymentRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc pushViewController:vc animated:YES];
    });
}

@end
