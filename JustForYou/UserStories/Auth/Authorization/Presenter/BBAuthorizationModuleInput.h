#import <Foundation/Foundation.h>

@protocol BBAuthorizationModuleInput <NSObject>

- (void)configureModule;

- (id)currentViewWithModule:(id)module;
- (id)currentView;


@end
