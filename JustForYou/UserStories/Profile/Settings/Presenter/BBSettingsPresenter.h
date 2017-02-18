#import "BBSettingsViewOutput.h"
#import "BBSettingsInteractorOutput.h"
#import "BBSettingsModuleInput.h"

@protocol BBSettingsViewInput;
@protocol BBSettingsInteractorInput;
@protocol BBSettingsRouterInput;

@interface BBSettingsPresenter : NSObject <BBSettingsModuleInput, BBSettingsViewOutput, BBSettingsInteractorOutput>

@property (strong, nonatomic) id<BBSettingsViewInput> view;
@property (strong, nonatomic) id<BBSettingsInteractorInput> interactor;
@property (strong, nonatomic) id<BBSettingsRouterInput> router;

@end
