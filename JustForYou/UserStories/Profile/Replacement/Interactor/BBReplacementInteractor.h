#import "BBReplacementInteractorInput.h"

@protocol BBReplacementInteractorOutput;

@interface BBReplacementInteractor : NSObject <BBReplacementInteractorInput>

@property (weak, nonatomic) id<BBReplacementInteractorOutput> output;

@end
