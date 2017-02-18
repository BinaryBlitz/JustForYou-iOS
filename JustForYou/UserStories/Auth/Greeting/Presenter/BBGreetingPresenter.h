#import "BBGreetingViewOutput.h"
#import "BBGreetingInteractorOutput.h"
#import "BBGreetingModuleInput.h"

@protocol BBGreetingViewInput;
@protocol BBGreetingInteractorInput;
@protocol BBGreetingRouterInput;

@interface BBGreetingPresenter : NSObject <BBGreetingModuleInput, BBGreetingViewOutput, BBGreetingInteractorOutput>

@property (strong, nonatomic) id<BBGreetingViewInput> view;
@property (strong, nonatomic) id<BBGreetingInteractorInput> interactor;
@property (strong, nonatomic) id<BBGreetingRouterInput> router;

@end
