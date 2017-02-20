#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBRegistrationRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end
