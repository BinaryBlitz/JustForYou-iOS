#import "BBBasketRouterInput.h"

#import "BBBasketPresenter.h"

@interface BBBasketRouter : NSObject <BBBasketRouterInput>

@property (weak, nonatomic) BBBasketPresenter *presenter;

@end
