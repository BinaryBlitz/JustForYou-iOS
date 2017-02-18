#import <Foundation/Foundation.h>

@protocol BBMyProgramsViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)didSelectRowWithPurchase:(BBPurchases *)purchase;

- (void)viewWillAppear;

@end
