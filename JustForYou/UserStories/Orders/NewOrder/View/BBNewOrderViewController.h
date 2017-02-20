#import <UIKit/UIKit.h>

#import "BBNewOrderViewInput.h"

@protocol BBNewOrderViewOutput;

@interface BBNewOrderViewController : BBParentViewController <BBNewOrderViewInput>

@property (weak, nonatomic) id <BBNewOrderViewOutput> output;

@end
