#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBOrdersRouterInput <NSObject>

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;
- (void)presentFirstItemOnTabbar;

- (void)updateCountPurchasesUser;

@end
