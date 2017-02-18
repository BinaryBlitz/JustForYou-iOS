#import "BBGreetingRouterInput.h"

#import "BBGreetingPresenter.h"

@interface BBGreetingRouter : NSObject <BBGreetingRouterInput>

@property (weak, nonatomic) BBGreetingPresenter *presenter;

@end
