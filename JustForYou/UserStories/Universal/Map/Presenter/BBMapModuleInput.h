#import <Foundation/Foundation.h>

@protocol BBMapModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parent;

@end
