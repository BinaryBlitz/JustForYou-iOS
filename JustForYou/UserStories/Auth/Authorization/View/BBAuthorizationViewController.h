#import <UIKit/UIKit.h>

#import "BBAuthorizationViewInput.h"

@protocol BBAuthorizationViewOutput;

@interface BBAuthorizationViewController : BBParentViewController <BBAuthorizationViewInput>

@property (nonatomic, weak) id<BBAuthorizationViewOutput> output;

@end
