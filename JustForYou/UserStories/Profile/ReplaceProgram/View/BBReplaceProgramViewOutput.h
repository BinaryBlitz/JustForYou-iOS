#import <Foundation/Foundation.h>

@protocol BBReplaceProgramViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;
- (void)viewWillAppear;

- (void)cellDidSelectRowWithProgram:(BBProgram *)program;

- (void)okCancelButtonDidTapWithKey:(BBKeyForOkButtonAlert)key;
- (void)cancelButtonDidTap;

- (void)payNewCardButtonDidTap;
- (void)payCardWithCard:(BBPayCard *)card;

@end
