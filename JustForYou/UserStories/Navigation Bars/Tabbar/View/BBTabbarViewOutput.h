#import <Foundation/Foundation.h>

@protocol BBTabbarViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

@end
