#import <Foundation/Foundation.h>

@protocol BBAddressViewInput <NSObject>

- (void)setupInitialState;

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)updateTableViewWithAddress:(BBAddress *)address;

- (void)clearFields;

- (void)saveApartmentWithString:(NSString *)apartment;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;

@end
