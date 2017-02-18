#import <Foundation/Foundation.h>

@protocol BBSettingsInteractorOutput <NSObject>

- (void)updateUserSuccessfully;

- (void)userLogoutSuccessfully;

- (void)noConnectionNetwork;

- (void)errorServer;


@end
