#import "BBProfileRouter.h"

@implementation BBProfileRouter

#pragma mark - BBProfileRouterInput

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc {
    HQDispatchToMainQueue(^{
        [nc popViewControllerAnimated:YES];
    });
}

@end
