#import "BBAuthorizationViewOutput.h"
#import "BBAuthorizationInteractorOutput.h"
#import "BBAuthorizationModuleInput.h"

@protocol BBAuthorizationViewInput;
@protocol BBAuthorizationInteractorInput;
@protocol BBAuthorizationRouterInput;

@interface BBAuthorizationPresenter : NSObject <BBAuthorizationModuleInput, BBAuthorizationViewOutput, BBAuthorizationInteractorOutput>

@property (strong, nonatomic) id <BBAuthorizationViewInput> view;
@property (strong, nonatomic) id <BBAuthorizationInteractorInput> interactor;
@property (strong, nonatomic) id <BBAuthorizationRouterInput> router;

@end
