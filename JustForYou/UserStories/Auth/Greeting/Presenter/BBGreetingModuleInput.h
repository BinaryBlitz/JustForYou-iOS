#import <Foundation/Foundation.h>

@protocol BBGreetingModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule;

@end
