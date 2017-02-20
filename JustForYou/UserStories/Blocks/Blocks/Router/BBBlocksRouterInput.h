#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBBlocksRouterInput <NSObject>

- (void)presentFromWindow:(UIWindow *)window;

- (void)presentBasketViewControllerWithController:(UINavigationController *)basketNC
                         withNavigationController:(UINavigationController *)nc;

@end
