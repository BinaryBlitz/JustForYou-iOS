#import <UIKit/UIKit.h>

#import "BBBasketViewInput.h"

@protocol BBBasketViewOutput;

@interface BBBasketViewController : BBParentViewController <BBBasketViewInput>

@property (weak, nonatomic) id <BBBasketViewOutput> output;

@end
