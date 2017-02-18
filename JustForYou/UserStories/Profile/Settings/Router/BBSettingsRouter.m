#import "BBSettingsRouter.h"

@implementation BBSettingsRouter

#pragma mark - BBSettingsRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
  UIViewController *vc = (UIViewController *) self.presenter.view;
  HQDispatchToMainQueue(^{
    [nc pushViewController:vc animated:YES];
  });
}

- (void)popSelfViewControllerWithNavigationController:(UINavigationController *)nc {
  HQDispatchToMainQueue(^{
    [nc popViewControllerAnimated:NO];
  });
}

@end
