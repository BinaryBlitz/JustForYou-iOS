#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBMyProgramsRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;

@end
