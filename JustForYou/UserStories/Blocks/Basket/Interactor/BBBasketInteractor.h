#import "BBBasketInteractorInput.h"

@protocol BBBasketInteractorOutput;

@interface BBBasketInteractor : NSObject <BBBasketInteractorInput>

@property (weak, nonatomic) id<BBBasketInteractorOutput> output;

@end
