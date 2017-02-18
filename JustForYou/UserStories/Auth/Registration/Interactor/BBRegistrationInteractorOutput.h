#import <Foundation/Foundation.h>

@protocol BBRegistrationInteractorOutput <NSObject>

- (void)userSuccessfullySaved;

- (void)noConnectionNetwork;

- (void)errorServer;


@end
