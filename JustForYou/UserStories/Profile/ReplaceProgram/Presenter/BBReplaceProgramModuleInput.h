#import <Foundation/Foundation.h>

#import "BBPurchases.h"

@protocol BBReplaceProgramModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule purchase:(BBPurchases *)purchase;
- (void)paySucces;

@end
