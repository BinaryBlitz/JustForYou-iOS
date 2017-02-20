#import <Foundation/Foundation.h>

@protocol BBGreetingViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)nextButtonDidTapWithPage:(NSInteger)page;

@end
