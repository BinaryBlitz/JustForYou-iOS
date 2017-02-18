#import "BBGreetingRouter.h"

@implementation BBGreetingRouter

#pragma mark - BBGreetingRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc pushViewController:vc animated:YES];
    });
}


@end
