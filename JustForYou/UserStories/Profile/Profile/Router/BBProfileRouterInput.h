#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBProfileRouterInput <NSObject>

- (void)popViewControllerWithNavigationController:(UINavigationController *)nc;

@end
