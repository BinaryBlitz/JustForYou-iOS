#import "BBRegistrationRouter.h"

@interface BBRegistrationRouter ()

@end

@implementation BBRegistrationRouter

#pragma mark - BBRegistrationRouterInput

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc {
  UIViewController *vc = (UIViewController *) self.presenter.view;
  HQDispatchToMainQueue(^{
    [nc pushViewController:vc animated:YES];
  });
}

@end
