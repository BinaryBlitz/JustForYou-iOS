#import "BBReplaceProgramRouter.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBReplaceProgramRouter

#pragma mark - BBReplaceProgramRouterInput

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

- (void)updateCountPurchasesUser {
  UIViewController *view = (UIViewController *) self.presenter.view;
  [[BBServerService sharedService] updateUserCountsPurchasesWithUserToken:[[BBUserService sharedService] tokenUser] tabbar:(BBTabbarViewController *) view.tabBarController];
}

@end
