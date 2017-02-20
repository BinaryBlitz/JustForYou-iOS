#import <Foundation/Foundation.h>

@protocol BBMyHistoryViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

@end
