#import <Foundation/Foundation.h>

@protocol BBSupportViewInput <NSObject>

- (void)setupInitialState;

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message;

@end
