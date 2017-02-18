#import <UIKit/UIKit.h>

#import "BBAddressViewInput.h"

@protocol BBAddressViewOutput;

@interface BBAddressViewController : BBParentViewController <BBAddressViewInput>

@property (weak, nonatomic) id <BBAddressViewOutput> output;

@end
