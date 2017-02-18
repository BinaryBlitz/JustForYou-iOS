#import <UIKit/UIKit.h>

#import "BBReplaceProgramViewInput.h"

@protocol BBReplaceProgramViewOutput;

@interface BBReplaceProgramViewController : BBParentViewController <BBReplaceProgramViewInput>

@property (weak, nonatomic) id <BBReplaceProgramViewOutput> output;

@end
