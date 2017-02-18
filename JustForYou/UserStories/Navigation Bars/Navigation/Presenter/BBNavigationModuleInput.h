#import <Foundation/Foundation.h>

#import "BBNavigationModuleOutput.h"

@protocol BBNavigationModuleInput <NSObject>

- (id)currentViewWithLoadModule:(BBLoadModule) loadModule;

- (id)currentView;

- (void)configureModule;

- (void)presentInWindow:(UIWindow *)window;

- (void)userRegistrationFulfilled;

- (void)userLogout;

- (void)pushViewControllerWithView:(id)view;

- (void)setToMeTabbarModule:(id)tabbarModule;

@property (strong, nonatomic) id<BBNavigationModuleOutput> output;

@end
