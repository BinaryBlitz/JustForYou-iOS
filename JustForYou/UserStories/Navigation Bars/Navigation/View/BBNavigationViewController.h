#import <UIKit/UIKit.h>

#import "BBNavigationViewInput.h"

@protocol BBNavigationViewOutput;

@interface BBNavigationViewController : UINavigationController <BBNavigationViewInput>

@property (weak, nonatomic) id <BBNavigationViewOutput> output;

@end
