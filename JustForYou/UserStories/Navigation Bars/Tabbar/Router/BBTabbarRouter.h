#import "BBTabbarRouterInput.h"

#import "BBTabbarPresenter.h"

@interface BBTabbarRouter : NSObject <BBTabbarRouterInput>

@property (weak, nonatomic) BBTabbarPresenter *presenter;

@end
