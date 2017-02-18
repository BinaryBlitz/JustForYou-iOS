#import "BBOrdersInteractorInput.h"

@protocol BBOrdersInteractorOutput;

@interface BBOrdersInteractor : NSObject <BBOrdersInteractorInput>

@property (weak, nonatomic) id<BBOrdersInteractorOutput> output;

@end
