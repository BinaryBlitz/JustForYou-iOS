#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBProgramsRouterInput <NSObject>

- (void)pushViewControllerWithNavigationController:(UINavigationController *)nc;

- (void)presentBasketViewControllerWithController:(UINavigationController *)basketNC
                         withNavigationController:(UINavigationController *)nc;

- (void)callManagerOnPhone:(NSString *)phoneManager;

@end
