#import "BBMapInteractorInput.h"

@protocol BBMapInteractorOutput;

@interface BBMapInteractor : NSObject <BBMapInteractorInput>

@property (weak, nonatomic) id <BBMapInteractorOutput> output;

@end
