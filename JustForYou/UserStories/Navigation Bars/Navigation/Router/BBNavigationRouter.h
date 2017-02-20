#import "BBNavigationRouterInput.h"

#import "BBNavigationPresenter.h"

@interface BBNavigationRouter : NSObject <BBNavigationRouterInput>

@property (weak, nonatomic) BBNavigationPresenter *presenter;

@end
