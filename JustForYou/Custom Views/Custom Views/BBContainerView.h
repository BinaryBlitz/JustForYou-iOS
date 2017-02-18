#import <UIKit/UIKit.h>

@interface BBContainerView : UIView

@property (weak, nonatomic) UIViewController* parentVC;

- (void)displayView:(id)view;

@end
