#import "BBBlocksInteractorInput.h"

@protocol BBBlocksInteractorOutput;

@interface BBBlocksInteractor : NSObject <BBBlocksInteractorInput>

@property (weak, nonatomic) id<BBBlocksInteractorOutput> output;

@end
