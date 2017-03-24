#import <Foundation/Foundation.h>

@protocol BBAuthorizationInteractorOutput <NSObject>

- (void)sendCodeSuccessfullyWithAuthToken:(NSString *)token;

- (void)codeSuccessfullyButUserMissingOnServer;
- (void)codeSuccessfullyWithUserToken:(NSString *)token;

- (void)userSuccessfullAuthorizate;

- (void)noConnectionNetwork;

- (void)errorServer;

- (void)setTabBarViewController;

@end
