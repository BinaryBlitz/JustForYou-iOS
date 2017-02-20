#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBMapRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end
