#import <UIKit/UIKit.h>

#import "BBTabbarViewInput.h"

@protocol BBTabbarViewOutput;

@interface BBTabbarViewController : UITabBarController <BBTabbarViewInput>

@property (weak, nonatomic) id<BBTabbarViewOutput> output;

@property (strong, nonatomic) UILabel *indicatorLabel;

@end
