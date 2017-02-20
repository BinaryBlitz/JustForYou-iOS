#import <UIKit/UIKit.h>

#import "BBBlocksViewInput.h"

@protocol BBBlocksViewOutput;

@interface BBBlocksViewController : BBParentViewController <BBBlocksViewInput>

@property (weak, nonatomic) id <BBBlocksViewOutput> output;

@end
