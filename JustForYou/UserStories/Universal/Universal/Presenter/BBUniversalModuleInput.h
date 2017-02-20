#import <Foundation/Foundation.h>

@protocol BBUniversalModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule keyModule:(BBKeyModuleForUniversalModule)key;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule keyModule:(BBKeyModuleForUniversalModule)key;

@end
