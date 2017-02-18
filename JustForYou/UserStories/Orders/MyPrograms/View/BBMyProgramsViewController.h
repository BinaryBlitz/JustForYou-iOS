#import <UIKit/UIKit.h>

#import "BBMyProgramsViewInput.h"

@protocol BBMyProgramsViewOutput;

@interface BBMyProgramsViewController : BBParentViewController <BBMyProgramsViewInput>

@property (weak, nonatomic) id<BBMyProgramsViewOutput> output;

@end
