#import "BBCardProgramInteractorInput.h"

@protocol BBCardProgramInteractorOutput;

@interface BBCardProgramInteractor : NSObject <BBCardProgramInteractorInput>

@property (weak, nonatomic) id <BBCardProgramInteractorOutput> output;

@end
