#import "BBMyProgramsRouter.h"

@implementation BBMyProgramsRouter

#pragma mark - BBMyProgramsRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
  UIViewController *vc = (UIViewController *) self.presenter.view;
  HQDispatchToMainQueue(^{
    [nc pushViewController:vc animated:YES];
  });
}

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc {
  HQDispatchToMainQueue(^{
    [nc popViewControllerAnimated:YES];
  });
}

@end
