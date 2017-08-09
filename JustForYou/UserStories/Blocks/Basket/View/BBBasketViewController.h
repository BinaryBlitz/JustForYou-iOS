#import <UIKit/UIKit.h>

#import "BBBasketViewInput.h"

@protocol BBBasketViewOutput;

@interface BBBasketViewController : BBParentViewController <BBBasketViewInput>

@property (weak, nonatomic) id <BBBasketViewOutput> output;
@property (strong, nonatomic) void (^resetButtonHandler)(void);


@end
