#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBNavigationRouterInput <NSObject>

- (void)presentFromWindow:(UIWindow *)window;

- (void)rootVC:(id)view;
- (void)popToRootViewController;
- (void)pushViewController:(id)view;

@end
