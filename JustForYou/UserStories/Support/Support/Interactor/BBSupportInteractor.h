#import "BBSupportInteractorInput.h"

@protocol BBSupportInteractorOutput;

@interface BBSupportInteractor : NSObject <BBSupportInteractorInput>

@property (weak, nonatomic) id <BBSupportInteractorOutput> output;

@end
