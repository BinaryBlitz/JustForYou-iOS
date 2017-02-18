#import "BBAuthorizationRouter.h"

@implementation BBAuthorizationRouter

#pragma mark - BBAuthorizationRouterInput

- (void)presentFromWindow:(UIWindow *)window {
    HQDispatchToMainQueue(^{
        [window setRootViewController:(UIViewController *)self.presenter.view];
        [window makeKeyAndVisible];
    });
}

@end
