#import <UIKit/UIKit.h>

#import "BBStockViewInput.h"

@protocol BBStockViewOutput;

@interface BBStockViewController : UIViewController <BBStockViewInput>

@property (weak, nonatomic) id <BBStockViewOutput> output;

@end
