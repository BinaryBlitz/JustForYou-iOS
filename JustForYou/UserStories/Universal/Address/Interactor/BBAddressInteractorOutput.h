#import <Foundation/Foundation.h>

@protocol BBAddressInteractorOutput <NSObject>

- (void)addressDidSaveWithStatus:(BOOL)status;

- (void)errorNetwork;
- (void)errorServer;

@end
