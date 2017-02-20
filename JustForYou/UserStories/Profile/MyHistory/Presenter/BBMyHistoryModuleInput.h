#import <Foundation/Foundation.h>

@protocol BBMyHistoryModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentModule:(id)parentModule;

@end
