#import <Foundation/Foundation.h>

#import "BBPayCard.h"

typedef enum : NSUInteger {
    kTypeNewPayment,
    kTypeCardPayment
}BBTypePayment;

@protocol BBBasketInteractorInput <NSObject>

- (void)currentOrdersInBasket;

- (NSArray *)deleteOrderProgramOnUserArray:(BBOrderProgram *)orderProgram;
- (void)updateUserAndShowCurrentBonuses;

- (void)deleteAllOrderProgramsOnUser;

- (void)createOrderOnServerWithTypePayment:(BBTypePayment)type payCard:(BBPayCard *)card useBonuses:(BOOL)use;

- (NSArray *)currentUserPayCards;

@end
