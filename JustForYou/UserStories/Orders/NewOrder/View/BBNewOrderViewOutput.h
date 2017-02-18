#import <Foundation/Foundation.h>

@protocol BBNewOrderViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)countDayCellDidTap;
- (void)adresCellDidTap;

- (void)toOrderButtonDidTapWithComment:(NSString *)comment startHour:(NSInteger)hour startMinute:(NSInteger)minute;

- (void)alertOkDidTap;

@end
