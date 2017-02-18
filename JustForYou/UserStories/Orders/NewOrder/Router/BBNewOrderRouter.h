#import "BBNewOrderRouterInput.h"

#import "BBNewOrderPresenter.h"

@interface BBNewOrderRouter : NSObject <BBNewOrderRouterInput>

@property (weak, nonatomic) BBNewOrderPresenter *presenter;

@end
