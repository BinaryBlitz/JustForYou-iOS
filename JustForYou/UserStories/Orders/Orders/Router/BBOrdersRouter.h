#import "BBOrdersRouterInput.h"

#import "BBOrdersPresenter.h"

@interface BBOrdersRouter : NSObject <BBOrdersRouterInput>

@property (weak, nonatomic) BBOrdersPresenter *presenter;

@end
