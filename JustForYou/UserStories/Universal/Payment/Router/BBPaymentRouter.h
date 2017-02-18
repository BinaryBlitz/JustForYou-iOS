#import "BBPaymentRouterInput.h"

#import "BBPaymentPresenter.h"

@interface BBPaymentRouter : NSObject <BBPaymentRouterInput>

@property (weak, nonatomic) BBPaymentPresenter *presenter;

@end
