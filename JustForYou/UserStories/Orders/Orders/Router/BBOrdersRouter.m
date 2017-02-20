#import "BBOrdersRouter.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBOrdersRouter

#pragma mark - BBOrdersRouterInput

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc {
  HQDispatchToMainQueue(^{
    [nc popViewControllerAnimated:YES];
  });
}

- (void)presentFirstItemOnTabbar {
  HQDispatchToMainQueue(^{
    UIViewController *view = (UIViewController *) self.presenter.view;
    [view.tabBarController setSelectedIndex:0];
  });
}

- (void)updateCountPurchasesUser {
  UIViewController *view = (UIViewController *) self.presenter.view;
  [[BBServerService sharedService] updateUserCountsPurchasesWithUserToken:[[BBUserService sharedService] tokenUser] tabbar:(BBTabbarViewController *) view.tabBarController];
}

@end
