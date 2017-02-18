#import "BBAddressInteractorInput.h"

@protocol BBAddressInteractorOutput;

@interface BBAddressInteractor : NSObject <BBAddressInteractorInput>

@property (weak, nonatomic) id<BBAddressInteractorOutput> output;

@end
