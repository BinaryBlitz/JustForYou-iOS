#import "BBRegistrationViewOutput.h"
#import "BBRegistrationInteractorOutput.h"
#import "BBRegistrationModuleInput.h"

@protocol BBRegistrationViewInput;
@protocol BBRegistrationInteractorInput;
@protocol BBRegistrationRouterInput;

@interface BBRegistrationPresenter : NSObject <BBRegistrationModuleInput, BBRegistrationViewOutput, BBRegistrationInteractorOutput>

@property (strong, nonatomic) id<BBRegistrationViewInput> view;
@property (strong, nonatomic) id<BBRegistrationInteractorInput> interactor;
@property (strong, nonatomic) id<BBRegistrationRouterInput> router;

@end
