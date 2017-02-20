#import "BBReplaceProgramViewOutput.h"
#import "BBReplaceProgramInteractorOutput.h"
#import "BBReplaceProgramModuleInput.h"

@protocol BBReplaceProgramViewInput;
@protocol BBReplaceProgramInteractorInput;
@protocol BBReplaceProgramRouterInput;

@interface BBReplaceProgramPresenter : NSObject <BBReplaceProgramModuleInput, BBReplaceProgramViewOutput, BBReplaceProgramInteractorOutput>

@property (strong, nonatomic) id <BBReplaceProgramViewInput> view;
@property (strong, nonatomic) id <BBReplaceProgramInteractorInput> interactor;
@property (strong, nonatomic) id <BBReplaceProgramRouterInput> router;

@end
