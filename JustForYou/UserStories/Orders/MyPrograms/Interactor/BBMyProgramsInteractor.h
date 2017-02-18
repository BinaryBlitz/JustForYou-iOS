#import "BBMyProgramsInteractorInput.h"

@protocol BBMyProgramsInteractorOutput;

@interface BBMyProgramsInteractor : NSObject <BBMyProgramsInteractorInput>

@property (weak, nonatomic) id<BBMyProgramsInteractorOutput> output;

@end
