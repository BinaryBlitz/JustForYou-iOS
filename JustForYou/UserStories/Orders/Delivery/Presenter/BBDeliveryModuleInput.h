#import <Foundation/Foundation.h>

@protocol BBDeliveryModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule parent:(id)parent purchase:(BBPurchases *)purchase program:(BBProgram *)program daysArray:(NSArray *)days;

@end
