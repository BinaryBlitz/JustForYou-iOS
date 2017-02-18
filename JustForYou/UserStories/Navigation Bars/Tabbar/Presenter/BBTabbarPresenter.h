#import "BBTabbarViewOutput.h"
#import "BBTabbarInteractorOutput.h"
#import "BBTabbarModuleInput.h"

@protocol BBTabbarViewInput;
@protocol BBTabbarInteractorInput;
@protocol BBTabbarRouterInput;

@interface BBTabbarPresenter : NSObject <BBTabbarModuleInput, BBTabbarViewOutput, BBTabbarInteractorOutput>

@property (strong, nonatomic) id <BBTabbarViewInput> view;
@property (strong, nonatomic) id <BBTabbarInteractorInput> interactor;
@property (strong, nonatomic) id <BBTabbarRouterInput> router;

@end
