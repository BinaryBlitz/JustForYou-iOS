#import <Foundation/Foundation.h>

@protocol BBProgramsModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parentId:(NSInteger)parentId;

@end
