#import "BBTabbarRouter.h"

@implementation BBTabbarRouter

#pragma mark - BBTabbarRouterInput

- (void)presentFromWindow:(UIWindow *)window {
  HQDispatchToMainQueue(^{
    [window setRootViewController:(UIViewController *) self.presenter.view];
    [window makeKeyAndVisible];
  });
}

@end
