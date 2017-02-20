#import "BBProfileInteractorInput.h"

@protocol BBProfileInteractorOutput;

@interface BBProfileInteractor : NSObject <BBProfileInteractorInput>

@property (weak, nonatomic) id <BBProfileInteractorOutput> output;

@end
