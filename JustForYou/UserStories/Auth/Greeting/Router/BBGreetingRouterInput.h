#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBGreetingRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end
