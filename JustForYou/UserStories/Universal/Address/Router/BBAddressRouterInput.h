#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBAddressRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;
- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;

@end
