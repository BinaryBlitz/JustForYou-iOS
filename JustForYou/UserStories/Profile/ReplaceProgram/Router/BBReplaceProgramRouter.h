#import "BBReplaceProgramRouterInput.h"

#import "BBReplaceProgramPresenter.h"

@interface BBReplaceProgramRouter : NSObject <BBReplaceProgramRouterInput>

@property (weak, nonatomic) BBReplaceProgramPresenter *presenter;

@end
