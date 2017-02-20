#import <Foundation/Foundation.h>

@protocol BBListMyProgViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)okButtonDidTapWithCountDays:(NSInteger)count programId:(NSInteger)programId;

- (void)replaceButtonDidTapWithPurchase:(BBPurchases *)purchase;


@end
