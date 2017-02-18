#import "BBPaymentInteractorInput.h"

@protocol BBPaymentInteractorOutput;

@interface BBPaymentInteractor : NSObject <BBPaymentInteractorInput>

@property (weak, nonatomic) id<BBPaymentInteractorOutput> output;

@end
