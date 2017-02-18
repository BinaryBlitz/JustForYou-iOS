#import "BBListMyProgRouterInput.h"

#import "BBListMyProgPresenter.h"

@interface BBListMyProgRouter : NSObject <BBListMyProgRouterInput>

@property (weak, nonatomic) BBListMyProgPresenter *presenter;

@end
