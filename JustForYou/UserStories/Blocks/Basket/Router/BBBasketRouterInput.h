#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBBasketRouterInput <NSObject>

- (void)dissmissViewControllerWithNavigation:(UINavigationController *)nc;
- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;

- (void)updateCountPurchasesUser;

@end
