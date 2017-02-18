#import <Foundation/Foundation.h>

@protocol BBBasketViewInput <NSObject>

- (void)setupInitialState;

- (void)updateTableViewWithOrders:(NSArray *)orders;
- (void)updateTableViewWithDelete:(NSArray *)objects;

- (void)updateTotalTableViewCell;
- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentNoteAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message titleAction:(NSString *)titleAction;

- (void)createAndPresentTableAlertWithMessage:(NSString *)message;

@end
