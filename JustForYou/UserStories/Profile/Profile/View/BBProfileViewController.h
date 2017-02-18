#import <UIKit/UIKit.h>

#import "BBProfileViewInput.h"

@protocol BBProfileViewOutput;

@interface BBProfileViewController : BBParentViewController <BBProfileViewInput>

@property (weak, nonatomic) id<BBProfileViewOutput> output;

@end
