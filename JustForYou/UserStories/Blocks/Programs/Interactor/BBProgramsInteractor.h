#import "BBProgramsInteractorInput.h"

@protocol BBProgramsInteractorOutput;

@interface BBProgramsInteractor : NSObject <BBProgramsInteractorInput>

@property (weak, nonatomic) id <BBProgramsInteractorOutput> output;

@end
