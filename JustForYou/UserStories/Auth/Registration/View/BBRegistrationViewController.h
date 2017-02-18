#import <UIKit/UIKit.h>

#import "BBRegistrationViewInput.h"

@protocol BBRegistrationViewOutput;

@interface BBRegistrationViewController : BBParentViewController <BBRegistrationViewInput>

@property (weak, nonatomic) id<BBRegistrationViewOutput> output;

@end
