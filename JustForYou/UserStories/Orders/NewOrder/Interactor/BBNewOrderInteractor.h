#import "BBNewOrderInteractorInput.h"

@protocol BBNewOrderInteractorOutput;

@interface BBNewOrderInteractor : NSObject <BBNewOrderInteractorInput>

@property (weak, nonatomic) id<BBNewOrderInteractorOutput> output;

@end
