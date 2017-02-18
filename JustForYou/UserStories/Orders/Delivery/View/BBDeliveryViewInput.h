#import <Foundation/Foundation.h>

@protocol BBDeliveryViewInput <NSObject>

- (void)setupInitialState;

- (void)purchaseForCalendar:(BBPurchases *)purchase selectionDates:(NSArray *)days;

- (NSArray *)currentSelectionDates;

@end
