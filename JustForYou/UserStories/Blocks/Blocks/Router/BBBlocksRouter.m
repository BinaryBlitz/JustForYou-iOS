#import "BBBlocksRouter.h"

@implementation BBBlocksRouter

#pragma mark - BBBlocksRouterInput

- (void)presentFromWindow:(UIWindow *)window {
  HQDispatchToMainQueue(^{
    [window setRootViewController:(UIViewController *) self.presenter.view];
    [window makeKeyAndVisible];
  });
}

- (void)presentBasketViewControllerWithController:(UINavigationController *)basketNC
                         withNavigationController:(UINavigationController *)nc {
  HQDispatchToMainQueue(^{
    [nc presentViewController:basketNC animated:YES completion:nil];
  });
}

@end
