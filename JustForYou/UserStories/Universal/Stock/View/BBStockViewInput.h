#import <Foundation/Foundation.h>

@protocol BBStockViewInput <NSObject>

- (void)setupInitialState;

- (void)stockForUI:(BBStock *)stock;

@end
