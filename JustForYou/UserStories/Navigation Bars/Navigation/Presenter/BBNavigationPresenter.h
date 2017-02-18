#import "BBNavigationViewOutput.h"
#import "BBNavigationInteractorOutput.h"
#import "BBNavigationModuleInput.h"

@protocol BBNavigationViewInput;
@protocol BBNavigationInteractorInput;
@protocol BBNavigationRouterInput;

@interface BBNavigationPresenter : NSObject <BBNavigationModuleInput, BBNavigationViewOutput, BBNavigationInteractorOutput>

@property (strong, nonatomic) id<BBNavigationViewInput> view;
@property (strong, nonatomic) id<BBNavigationInteractorInput> interactor;
@property (strong, nonatomic) id<BBNavigationRouterInput> router;

@end
