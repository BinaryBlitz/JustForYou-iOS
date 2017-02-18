#import <Foundation/Foundation.h>

@protocol BBReplacementViewInput <NSObject>

- (void)setupInitialState;

- (void)updateTableInsets;

- (NSInteger)countReplacementInTableView;

- (void)currentReplacementArray:(NSArray *)replacement;

- (void)presentAlertControllerWithMessage:(NSString *)message;

- (void)typeForController:(BBTypeReplacementController)type;

- (void)endUpdateTableViewWithNewReplacement:(NSArray *)replacement;

- (void)updateWithCategory:(NSArray *)category;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
