#import <UIKit/UIKit.h>

#import "BBSettingsViewInput.h"

@protocol BBSettingsViewOutput;

@interface BBSettingsViewController : BBParentViewController <BBSettingsViewInput>

@property (weak, nonatomic) id<BBSettingsViewOutput> output;

@end
