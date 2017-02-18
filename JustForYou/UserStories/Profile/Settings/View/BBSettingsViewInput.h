#import <Foundation/Foundation.h>

#import "BBUser.h"

@protocol BBSettingsViewInput <NSObject>

- (void)setupInitialState;

- (BBUser *)currentInfoUser;

- (void)updateInfoUserWithUser:(BBUser *)user;

- (void)showLoaderView;
- (void)hideLoaderView;

@end
