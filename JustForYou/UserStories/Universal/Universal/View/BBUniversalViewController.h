#import <UIKit/UIKit.h>

#import "BBUniversalViewInput.h"

@protocol BBUniversalViewOutput;

@interface BBUniversalViewController : BBParentViewController <BBUniversalViewInput>

@property (weak, nonatomic) id<BBUniversalViewOutput> output;

@end
