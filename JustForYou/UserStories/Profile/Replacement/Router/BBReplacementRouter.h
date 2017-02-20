#import "BBReplacementRouterInput.h"

#import "BBReplacementPresenter.h"

@interface BBReplacementRouter : NSObject <BBReplacementRouterInput>

@property (weak, nonatomic) BBReplacementPresenter *presenter;

@end
