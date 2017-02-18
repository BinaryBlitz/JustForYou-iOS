#import <Foundation/Foundation.h>

@protocol BBListMyProgModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule;

@end
