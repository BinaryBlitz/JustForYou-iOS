#import <Foundation/Foundation.h>

#import "BBReplacementCategory.h"

@protocol BBReplacementViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)addBarButtonDidTap;

- (void)deleteElementWithText:(BBReplacementProduct *)product;

- (void)cellDidSelectWithText:(BBReplacementProduct *)product;

@end
