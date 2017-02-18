#import <Foundation/Foundation.h>

@protocol BBSupportViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)writeManagerButtonDidTap;

- (void)callManagerButtonDidTap;

- (void)feedbackButtonDidTap;

- (void)facebookButtonDidTap;
- (void)instagramButtonDidTap;

@end
