#import "BBAuthorizationInteractorInput.h"

@protocol BBAuthorizationInteractorOutput;

@interface BBAuthorizationInteractor : NSObject <BBAuthorizationInteractorInput>

@property (weak, nonatomic) id<BBAuthorizationInteractorOutput> output;

@end
