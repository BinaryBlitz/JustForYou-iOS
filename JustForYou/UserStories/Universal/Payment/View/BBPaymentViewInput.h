#import <Foundation/Foundation.h>

#import "BBPayment.h"

@protocol BBPaymentViewInput <NSObject>

- (void)setupInitialState;

- (void)loadWebViewWithPayment:(BBPayment *)payment;

@end
