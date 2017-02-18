#import "BBUniversalRouterInput.h"

#import "BBUniversalPresenter.h"

@interface BBUniversalRouter : NSObject <BBUniversalRouterInput>

@property (weak, nonatomic) BBUniversalPresenter *presenter;

@end
