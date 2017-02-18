#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBNewOrderRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;

@end
