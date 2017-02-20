#import <Foundation/Foundation.h>

@protocol BBSettingsModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule;

@end
