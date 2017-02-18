#import <Foundation/Foundation.h>

#import "BBUser.h"

@protocol BBRegistrationViewInput <NSObject>

- (void)setupInitialState;

- (BBUser *)userWithTextFields;

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)showLoaderView;
- (void)hideLoaderView;

- (void)endEditingTextFields;

@end
