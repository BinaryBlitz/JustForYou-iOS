#import <Foundation/Foundation.h>

@protocol BBBlocksModuleInput <NSObject>

- (void)configureModule;

- (id)currentViewWithModule:(id)module;

@end
