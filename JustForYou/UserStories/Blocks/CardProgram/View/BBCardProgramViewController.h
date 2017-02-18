#import <UIKit/UIKit.h>

#import "BBCardProgramViewInput.h"

@protocol BBCardProgramViewOutput;

@interface BBCardProgramViewController : BBParentViewController <BBCardProgramViewInput>

@property (weak, nonatomic) id<BBCardProgramViewOutput> output;

@end
