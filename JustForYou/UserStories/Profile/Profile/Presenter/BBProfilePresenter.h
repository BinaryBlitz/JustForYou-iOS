#import "BBProfileViewOutput.h"
#import "BBProfileInteractorOutput.h"
#import "BBProfileModuleInput.h"

@protocol BBProfileViewInput;
@protocol BBProfileInteractorInput;
@protocol BBProfileRouterInput;

@interface BBProfilePresenter : NSObject <BBProfileModuleInput, BBProfileViewOutput, BBProfileInteractorOutput>

@property (strong, nonatomic) id <BBProfileViewInput> view;
@property (strong, nonatomic) id <BBProfileInteractorInput> interactor;
@property (strong, nonatomic) id <BBProfileRouterInput> router;

@end
