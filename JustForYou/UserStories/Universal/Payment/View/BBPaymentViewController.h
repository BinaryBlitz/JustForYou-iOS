#import <UIKit/UIKit.h>

#import "BBPaymentViewInput.h"

@protocol BBPaymentViewOutput;

@interface BBPaymentViewController : BBParentViewController <BBPaymentViewInput>

@property (weak, nonatomic) id <BBPaymentViewOutput> output;

@end
