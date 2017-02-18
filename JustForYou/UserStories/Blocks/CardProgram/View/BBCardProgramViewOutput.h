#import <Foundation/Foundation.h>

@protocol BBCardProgramViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)basketButtonDidTap;

- (void)addToBasketButtonDidTapWithProgram:(BBProgram *)program;

- (void)okButtonDidTapWithCountDays:(NSInteger)count;

@end
