#import <Foundation/Foundation.h>

@protocol BBUniversalInteractorInput <NSObject>

#pragma mark - Address

- (void)currentAddressArray;

- (void)deleteAddress:(BBAddress *)address;

#pragma mark - Stock

- (void)listShares;

#pragma  mark - PayCard

- (NSArray *)currentPayCards;

- (void)listPayCardsUser;

- (void)deletePaymentCardWithCard:(BBPayCard *)card;

@end
