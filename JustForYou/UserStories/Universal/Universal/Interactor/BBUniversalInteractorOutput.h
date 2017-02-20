#import <Foundation/Foundation.h>

@protocol BBUniversalInteractorOutput <NSObject>

- (void)currentAddressArray:(NSArray *)addressArray;
- (void)currentAddressArrayWithDeletedAddress:(NSArray *)array;

- (void)currentSharesWithArray:(NSArray *)array;

- (void)currentPayCardsUserWithArray:(NSArray *)array;
- (void)currentPayCardArrayWithDeletedCard:(NSArray *)array;

- (void)errorNetwork;
- (void)errorServer;

@end
