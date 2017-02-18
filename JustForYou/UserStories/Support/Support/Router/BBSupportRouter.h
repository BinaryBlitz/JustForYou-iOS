#import "BBSupportRouterInput.h"

#import "BBSupportPresenter.h"

@interface BBSupportRouter : NSObject <BBSupportRouterInput>

@property (weak, nonatomic) BBSupportPresenter *presenter;

@end
