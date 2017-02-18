#import <Foundation/Foundation.h>

#import "BBTabbarModuleOutput.h"

@protocol BBTabbarModuleInput <NSObject>

- (void)configureModule;

- (id)currentView;

- (void)userLogout;

- (void)presentInWindow:(UIWindow *)window;

@property (strong, nonatomic) id<BBTabbarModuleOutput> output;

@end
