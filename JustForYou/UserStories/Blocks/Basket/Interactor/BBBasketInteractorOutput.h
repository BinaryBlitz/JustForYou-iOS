#import <Foundation/Foundation.h>

@class BBPayment;

@protocol BBBasketInteractorOutput <NSObject>

- (void)currentOrders:(NSArray *)orders;

- (void)bonusesUpdate;

- (void)paymentDidStartWithPayment:(BBPayment *)payment;

- (void)paymentSuccessfull;
- (void)paymentError;

- (void)deliveryErrorWithOrder:(BBOrderProgram *)orderProgram;

- (void)errorServer;
- (void)errorNetwork;

@end

