#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBListMyProgRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end
