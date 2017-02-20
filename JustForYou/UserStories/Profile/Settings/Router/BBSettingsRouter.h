#import "BBSettingsRouterInput.h"

#import "BBSettingsPresenter.h"

@interface BBSettingsRouter : NSObject <BBSettingsRouterInput>

@property (weak, nonatomic) BBSettingsPresenter *presenter;

@end
