#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kNumberPhoneStyleTableView,
    kSendCodeStyleTableView
}BBKeyStyleTableViewRegist;

@protocol BBAuthorizationViewInput <NSObject>

- (void)setupInitialState;

- (void)showLoaderView;
- (void)hideLoaderView;

- (void)getCodeUser;

- (void)updateTableViewWithKeyTableView:(BBKeyStyleTableViewRegist)key;
- (void)keyForTableView:(BBKeyStyleTableViewRegist)key;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
