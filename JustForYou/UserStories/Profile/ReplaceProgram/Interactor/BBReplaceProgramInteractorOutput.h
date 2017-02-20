#import <Foundation/Foundation.h>

#import "BBExchange.h"

@protocol BBReplaceProgramInteractorOutput <NSObject>

- (void)allProgramsWithArray:(NSArray *)programs;

- (void)exchangeWithPayId:(NSInteger)payId payURL:(NSString *)url;

- (void)exchangeDidCreate:(BBExchange *)exchange;

- (void)errorNetwork;
- (void)errorServer;
- (void)paymentSuccessfull;
- (void)paymentError;

@end
