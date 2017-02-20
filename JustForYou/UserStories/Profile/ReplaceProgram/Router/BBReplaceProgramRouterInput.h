#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBReplaceProgramRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;
- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;

- (void)updateCountPurchasesUser;

@end
