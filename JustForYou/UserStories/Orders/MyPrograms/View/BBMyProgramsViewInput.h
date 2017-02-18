#import <Foundation/Foundation.h>

@protocol BBMyProgramsViewInput <NSObject>

- (void)setupInitialState;
- (void)purchasesWithArray:(NSArray *)array;

- (void)reloadTableView;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
