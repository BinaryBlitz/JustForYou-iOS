#import "BBMapRouter.h"

@implementation BBMapRouter

#pragma mark - BBMapRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
  UIViewController *vc = (UIViewController *) self.presenter.view;
  HQDispatchToMainQueue(^{
    [nc pushViewController:vc animated:YES];
  });
}

@end
