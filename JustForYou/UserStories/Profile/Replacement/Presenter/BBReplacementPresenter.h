#import "BBReplacementViewOutput.h"
#import "BBReplacementInteractorOutput.h"
#import "BBReplacementModuleInput.h"

@protocol BBReplacementViewInput;
@protocol BBReplacementInteractorInput;
@protocol BBReplacementRouterInput;

@interface BBReplacementPresenter : NSObject <BBReplacementModuleInput, BBReplacementViewOutput, BBReplacementInteractorOutput>

@property (strong, nonatomic) id <BBReplacementViewInput> view;
@property (strong, nonatomic) id <BBReplacementInteractorInput> interactor;
@property (strong, nonatomic) id <BBReplacementRouterInput> router;

@end
