#import "BBRegistrationInteractorInput.h"

@protocol BBRegistrationInteractorOutput;

@interface BBRegistrationInteractor : NSObject <BBRegistrationInteractorInput>

@property (weak, nonatomic) id <BBRegistrationInteractorOutput> output;

@end
