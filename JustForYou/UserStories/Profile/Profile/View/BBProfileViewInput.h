#import <Foundation/Foundation.h>

#import "BBUser.h"

@protocol BBProfileViewInput <NSObject>

- (void)setupInitialState;

- (void)currentUser:(BBUser *)user;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
