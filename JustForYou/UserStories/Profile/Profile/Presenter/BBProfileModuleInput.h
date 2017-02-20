#import <Foundation/Foundation.h>

@protocol BBProfileModuleInput <NSObject>

- (void)configureModule;

- (id)currentViewWithModule:(id)module;

- (void)popModule;

@end
