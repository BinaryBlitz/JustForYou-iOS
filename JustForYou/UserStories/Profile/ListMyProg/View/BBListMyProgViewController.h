#import <UIKit/UIKit.h>

#import "BBListMyProgViewInput.h"

@protocol BBListMyProgViewOutput;

@interface BBListMyProgViewController : BBParentViewController <BBListMyProgViewInput>

@property (weak, nonatomic) id <BBListMyProgViewOutput> output;

@end
