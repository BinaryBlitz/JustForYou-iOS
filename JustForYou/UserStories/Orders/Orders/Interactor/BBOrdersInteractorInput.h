#import <Foundation/Foundation.h>

@protocol BBOrdersInteractorInput <NSObject>

- (void)listMyDeliveriesOnDataBase;
- (void)myDeliveriesOnServer;
- (void)deleteOrderWithOrder:(BBOrder *)order;

- (void)listPurchasesUser;

- (void)checkMyDeliveryInvoices;
- (void)payDeliveriesWithTotal:(NSInteger)total invoicesId:(NSInteger)invoicesId card:(BBPayCard *)card;
- (void)payOnServerWithPayCard:(BBPayCard *)card paiId:(NSInteger)paiId;

@end
