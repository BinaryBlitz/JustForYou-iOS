#import <UIKit/UIKit.h>

#import "BBDeliveryViewInput.h"
#import "BBOrderViewControllerDelegate.h"

@protocol BBDeliveryViewOutput;

@interface BBDeliveryViewController : BBParentViewController <BBDeliveryViewInput>

@property (weak, nonatomic) id <BBDeliveryViewOutput> output;

@property (strong, nonatomic) id <BBOrderViewControllerDelegate> delegate;

@end
