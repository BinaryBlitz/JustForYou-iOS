#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBSettingsRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

- (void)popSelfViewControllerWithNavigationController:(UINavigationController *)nc;

@end
