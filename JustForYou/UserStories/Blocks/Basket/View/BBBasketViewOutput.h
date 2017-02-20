#import <Foundation/Foundation.h>

#import "BBPayCard.h"

@protocol BBBasketViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)removeButtonDidTapWithOrderProgram:(BBOrderProgram *)order;

- (void)closeButtonDidTap;
- (void)payButtonDidTapWithCount:(NSInteger)count;

- (void)changeStateWithState:(BOOL)state;

- (void)payNewCardButtonDidTap;
- (void)payCardWithCard:(BBPayCard *)card;
- (void)cancelButtonDidTap;

- (void)okCancelButtonDidTap;

@end
