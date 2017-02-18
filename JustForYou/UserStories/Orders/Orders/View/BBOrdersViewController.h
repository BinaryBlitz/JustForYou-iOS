#import <UIKit/UIKit.h>

#import "BBOrdersViewInput.h"

@protocol BBOrdersViewOutput;

@protocol BBOrderViewControllerDelegate;

@interface BBOrdersViewController : BBParentViewController <BBOrdersViewInput>

@property (weak, nonatomic) id<BBOrdersViewOutput> output;

@property (strong, nonatomic) id<BBOrderViewControllerDelegate> delegate;

@end
