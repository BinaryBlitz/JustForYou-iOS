#import <Foundation/Foundation.h>

@protocol BBMyHistoryViewInput <NSObject>

- (void)setupInitialState;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)updateTableViewWithArrayObjects:(NSArray *)objects;

@end
