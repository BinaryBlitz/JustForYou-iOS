#import <Foundation/Foundation.h>

#import "BBPurchases.h"

@protocol BBNewOrderViewInput <NSObject>

- (void)setupInitialState;

- (void)purchaseWithPurchase:(BBPurchases *)purchase;
- (void)programWithProgram:(BBProgram *)program;
- (void)orderProgramWithProgram:(BBOrderProgram *)orderProgram program:(BBProgram *)program;
- (void)countsDaysInCalendar:(NSInteger)counts;

- (void)adressForAdressTableViewCell:(NSString *)adress;
- (void)deleteAddress;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentFinishAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)popViewController;

@end
