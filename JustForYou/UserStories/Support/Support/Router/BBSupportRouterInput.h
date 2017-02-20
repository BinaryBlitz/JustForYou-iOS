#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBSupportRouterInput <NSObject>

- (void)presentMailController;

- (void)callManagerOnPhone:(NSString *)phoneManager;

- (void)presentITunseWithAppUrl:(NSString *)appURL;

- (void)openFacebookSocialGroup;
- (void)openInstagamSocialGroup;

@end
