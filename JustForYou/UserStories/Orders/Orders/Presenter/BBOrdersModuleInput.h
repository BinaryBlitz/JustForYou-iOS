#import <Foundation/Foundation.h>

@protocol BBOrdersModuleInput <NSObject>

- (void)configureModule;

- (id)currentViewWithModule:(id)module;

- (void)popViewControllerWithStatus:(BBStatusCreateDelivery)status;
- (void)paySucces;

@end
