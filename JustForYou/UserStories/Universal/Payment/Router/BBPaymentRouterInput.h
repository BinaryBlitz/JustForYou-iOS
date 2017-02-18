#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBPaymentRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end
