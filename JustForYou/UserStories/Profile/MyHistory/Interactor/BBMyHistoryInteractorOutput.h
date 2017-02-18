#import <Foundation/Foundation.h>

@protocol BBMyHistoryInteractorOutput <NSObject>

- (void)ordersWithArray:(NSArray *)orders;

- (void)errorNetwork;
- (void)errorServer;

@end
