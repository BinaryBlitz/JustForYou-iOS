#import <Foundation/Foundation.h>

@protocol BBSupportModuleInput <NSObject>

- (void)configureModule;

- (id)currentViewWithModule:(id)module;

@end
