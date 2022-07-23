#import <Foundation/Foundation.h>

@protocol BBDeliveryViewInput <NSObject>

- (void)setupInitialState;

- (void)purchaseForCalendar:(BBPurchases *)purchase program:(BBProgram *)program selectionDates:(NSArray *)days;

- (NSArray *)currentSelectionDates;

@end
