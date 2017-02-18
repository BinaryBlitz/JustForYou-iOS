#import <UIKit/UIKit.h>

#import "BBGreetingViewInput.h"

@protocol BBGreetingViewOutput;

@interface BBGreetingViewController : BBParentViewController <BBGreetingViewInput>

@property (weak, nonatomic) id <BBGreetingViewOutput> output;

@end
