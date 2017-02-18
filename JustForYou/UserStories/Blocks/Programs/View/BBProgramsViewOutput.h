#import <Foundation/Foundation.h>
#import "BBProgram.h"

@protocol BBProgramsViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)programDidTapWithProgram:(NSInteger)programId;

- (void)addToBasketButtonDidTapWithProgram:(BBProgram *)program;

- (void)okButtonDidTapWithCountDays:(NSInteger)count program:(BBProgram *)program;

- (void)errorOpenProgram;

- (void)basketButtonDidTap;

- (void)viewWillAppear;

@end
