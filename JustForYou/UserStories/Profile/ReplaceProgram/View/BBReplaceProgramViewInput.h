#import <Foundation/Foundation.h>

@protocol BBReplaceProgramViewInput <NSObject>

- (void)setupInitialState;

- (void)updateTableViewWithArray:(NSArray *)programs;
- (void)setPurchaseForReplace:(BBPurchases *)purchase;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message titleAction:(NSString *)titleAction cancelTitle:(NSString *)cancel key:(BBKeyForOkButtonAlert)key;

- (void)createAndPresentTableAlertWithMessage:(NSString *)message;

@end
