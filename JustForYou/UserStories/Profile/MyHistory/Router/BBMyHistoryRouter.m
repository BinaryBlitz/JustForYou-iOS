#import "BBMyHistoryRouter.h"

@implementation BBMyHistoryRouter

#pragma mark - BBMyHistoryRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [nc pushViewController:vc animated:YES];
    });
}
@end
