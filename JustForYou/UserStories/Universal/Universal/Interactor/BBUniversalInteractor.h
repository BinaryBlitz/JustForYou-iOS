#import "BBUniversalInteractorInput.h"

@protocol BBUniversalInteractorOutput;

@interface BBUniversalInteractor : NSObject <BBUniversalInteractorInput>

@property (weak, nonatomic) id<BBUniversalInteractorOutput> output;

@end
