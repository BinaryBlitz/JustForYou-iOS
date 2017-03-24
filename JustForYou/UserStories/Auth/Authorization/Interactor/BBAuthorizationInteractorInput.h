#import <Foundation/Foundation.h>

@protocol BBAuthorizationInteractorInput <NSObject>

- (void)sendNumberPhoneWithPhone:(NSString *)phone;

- (void)sendCodeUserWithCode:(NSString *)code numberPhone:(NSString *)phone authTiken:(NSString *)token;

- (void)getUserOnServerAndSaveWithToken:(NSString *)token;

- (void)setTabBarViewController;

@end
