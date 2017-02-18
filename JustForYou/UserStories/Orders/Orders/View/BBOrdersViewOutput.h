#import <Foundation/Foundation.h>

@protocol BBOrdersViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;
- (void)addNewOrderButtonDidTap;

- (void)viewWillAppear;

- (void)payNewCardButtonDidTap;
- (void)payCardWithCard:(BBPayCard *)card;
- (void)cancelButtonDidTap;

- (void)okCancelButtonDidTapWithKey:(BBKeyForOkButtonAlert)key;
- (void)deleteButtonDidTapWithOrder:(BBOrder *)order;

@end
