#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBStockRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end
