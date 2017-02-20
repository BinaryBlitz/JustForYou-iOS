#import <Foundation/Foundation.h>

@protocol BBListMyProgViewInput <NSObject>

- (void)setupInitialState;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)updateTableViewWithArrayObjects:(NSArray *)objects;

- (void)changeImageAndPresentAlertControllerWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle;

@end
