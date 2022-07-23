#import <Foundation/Foundation.h>

@protocol BBNewOrderInteractorInput <NSObject>

- (void)createDeliveryOnServerWithDays:(NSArray *)days address:(BBAddress *)address purchase:(BBPurchases *)purchase coment:(NSString *)coment hour:(NSInteger)hour minute:(NSInteger)minute;

- (void)addToBasketWithProgram:(BBProgram *)program address:(BBAddress *)address days:(NSArray *)days coment:(NSString *)coment hour:(NSInteger)hour minute:(NSInteger)minute;
@end
