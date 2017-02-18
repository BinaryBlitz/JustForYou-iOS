#import <Foundation/Foundation.h>

@protocol BBBasketModuleInput <NSObject>

- (id)currentViewWithModule:(id)module;

- (void)paySucces;

- (void)configureModule;

@end
