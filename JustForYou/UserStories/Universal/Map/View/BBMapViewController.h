#import <UIKit/UIKit.h>

#import "BBMapViewInput.h"

@protocol BBMapViewOutput;

@interface BBMapViewController : BBParentViewController <BBMapViewInput>

@property (weak, nonatomic) id <BBMapViewOutput> output;

@end
