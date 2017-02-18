#import "BBAuthorizationRouterInput.h"

#import "BBAuthorizationPresenter.h"

@interface BBAuthorizationRouter : NSObject <BBAuthorizationRouterInput>

@property (weak, nonatomic) BBAuthorizationPresenter *presenter;

@end
