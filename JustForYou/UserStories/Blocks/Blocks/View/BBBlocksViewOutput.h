#import <Foundation/Foundation.h>

@protocol BBBlocksViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)didSelectRowWithBlockId:(NSInteger)blockId;

- (void)basketButtonDidTap;

@end
