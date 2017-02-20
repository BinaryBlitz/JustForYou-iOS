#import <Foundation/Foundation.h>

@protocol BBStockModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule stock:(BBStock *)stock;

@end
