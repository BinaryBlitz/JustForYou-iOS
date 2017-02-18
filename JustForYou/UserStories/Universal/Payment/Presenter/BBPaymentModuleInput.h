#import <Foundation/Foundation.h>

@class BBPayment;

@protocol BBPaymentModuleInput <NSObject>

- (void)configureModule;

- (void)pushModuleWithNavigationModule:(id)navigationModule basketModule:(id)basketModule payment:(BBPayment *)payment;

@end
