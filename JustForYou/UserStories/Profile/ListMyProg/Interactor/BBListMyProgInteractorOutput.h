#import <Foundation/Foundation.h>

@protocol BBListMyProgInteractorOutput <NSObject>

- (void)errorNetwork;
- (void)errorServer;
- (void)currentPurchasesUserWithArray:(NSArray *)array;

@end
