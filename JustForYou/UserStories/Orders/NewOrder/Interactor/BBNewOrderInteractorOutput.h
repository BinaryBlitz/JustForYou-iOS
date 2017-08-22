#import <Foundation/Foundation.h>

@protocol BBNewOrderInteractorOutput <NSObject>

- (void)errorNetwork;
- (void)errorServer;

- (void)deliveriesCreateSuccessfull;
- (void)addBasketSuccessfull;

@end
