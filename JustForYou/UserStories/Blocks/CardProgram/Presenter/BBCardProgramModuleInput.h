#import <Foundation/Foundation.h>

#import "BBProgram.h"

@protocol BBCardProgramModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule prog:(NSInteger)prog;

@end
