#import <UIKit/UIKit.h>

#import "BBProgramsViewInput.h"

@protocol BBProgramsViewOutput;

@interface BBProgramsViewController : BBParentViewController <BBProgramsViewInput>

@property (weak, nonatomic) id <BBProgramsViewOutput> output;

@end
