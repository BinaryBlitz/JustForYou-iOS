#import <Foundation/Foundation.h>

@protocol BBOrdersInteractorOutput <NSObject>

- (void)deliveryInvoicesWithPayId:(NSInteger)payId payURL:(NSString *)url;
- (void)deliveryInvoicesNil;

- (void)currentMyDeliveriesWithArray:(NSArray *)array;
- (void)updateDeliveriesWithArray:(NSArray *)array;

- (void)createPayDeliveriesWithTotal:(NSInteger)total invoicesId:(NSInteger)invoicesId;

- (void)deliveriesDeleted;
- (void)errorNetwork;
- (void)errorServer;

- (void)paymentSuccessfull;
- (void)paymentError;

- (void)currentPurchasesUserWithArray:(NSArray *)array;

@end
