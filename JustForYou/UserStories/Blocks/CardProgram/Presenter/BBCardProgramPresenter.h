#import "BBCardProgramViewOutput.h"
#import "BBCardProgramInteractorOutput.h"
#import "BBCardProgramModuleInput.h"

@protocol BBCardProgramViewInput;
@protocol BBCardProgramInteractorInput;
@protocol BBCardProgramRouterInput;

@interface BBCardProgramPresenter : NSObject <BBCardProgramModuleInput, BBCardProgramViewOutput, BBCardProgramInteractorOutput>

@property (strong, nonatomic) id <BBCardProgramViewInput> view;
@property (strong, nonatomic) id <BBCardProgramInteractorInput> interactor;
@property (strong, nonatomic) id <BBCardProgramRouterInput> router;

- (void)errorCallManager;

@end
