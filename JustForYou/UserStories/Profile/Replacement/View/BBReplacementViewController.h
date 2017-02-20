#import <UIKit/UIKit.h>

#import "BBReplacementViewInput.h"

@protocol BBReplacementViewOutput;

@interface BBReplacementViewController : BBParentViewController <BBReplacementViewInput>

@property (weak, nonatomic) id <BBReplacementViewOutput> output;

@end
