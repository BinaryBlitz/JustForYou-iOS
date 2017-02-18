#import <Foundation/Foundation.h>

@protocol BBDeliveryModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchase:(BBPurchases *)purchase daysArray:(NSArray *)days;

@end
