#import "BBReplaceProgramInteractorInput.h"

@protocol BBReplaceProgramInteractorOutput;

@interface BBReplaceProgramInteractor : NSObject <BBReplaceProgramInteractorInput>

@property (weak, nonatomic) id <BBReplaceProgramInteractorOutput> output;

@end
