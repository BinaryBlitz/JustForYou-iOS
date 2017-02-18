#import "BBListMyProgInteractorInput.h"

@protocol BBListMyProgInteractorOutput;

@interface BBListMyProgInteractor : NSObject <BBListMyProgInteractorInput>

@property (weak, nonatomic) id<BBListMyProgInteractorOutput> output;

@end
