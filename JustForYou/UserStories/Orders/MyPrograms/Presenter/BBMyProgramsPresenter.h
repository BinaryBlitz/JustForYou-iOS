#import "BBMyProgramsViewOutput.h"
#import "BBMyProgramsInteractorOutput.h"
#import "BBMyProgramsModuleInput.h"

@protocol BBMyProgramsViewInput;
@protocol BBMyProgramsInteractorInput;
@protocol BBMyProgramsRouterInput;

@interface BBMyProgramsPresenter : NSObject <BBMyProgramsModuleInput, BBMyProgramsViewOutput, BBMyProgramsInteractorOutput>

@property (strong, nonatomic) id<BBMyProgramsViewInput> view;
@property (strong, nonatomic) id<BBMyProgramsInteractorInput> interactor;
@property (strong, nonatomic) id<BBMyProgramsRouterInput> router;

@end
