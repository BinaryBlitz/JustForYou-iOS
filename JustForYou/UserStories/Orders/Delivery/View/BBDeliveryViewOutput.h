#import <Foundation/Foundation.h>

@protocol BBDeliveryViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;
- (void)viewWillDisappear;
- (void)readyButtonDidTap;

@end
