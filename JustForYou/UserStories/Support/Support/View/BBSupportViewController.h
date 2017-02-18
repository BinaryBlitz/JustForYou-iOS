#import <UIKit/UIKit.h>

#import "BBSupportViewInput.h"

@protocol BBSupportViewOutput;

@interface BBSupportViewController : BBParentViewController <BBSupportViewInput>

@property (weak, nonatomic) id<BBSupportViewOutput> output;

@end
