#import "BBGreetingInteractorInput.h"

@protocol BBGreetingInteractorOutput;

@interface BBGreetingInteractor : NSObject <BBGreetingInteractorInput>

@property (weak, nonatomic) id <BBGreetingInteractorOutput> output;

@end
