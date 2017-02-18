#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBMyHistoryRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

@end
