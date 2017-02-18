#import <UIKit/UIKit.h>

#import "BBLoaderView.h"

#import "BBImageViewService.h"

#import "BBAppAnalitics.h"

@interface BBParentViewController : UIViewController

@property (strong, nonatomic) BBLoaderView *loaderView;

- (void)showLoaderView;
- (void)hideLoaderView;

- (void)showBackgroundLoaderView;
- (void)hideBackgroundLoaderView;

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha;
- (void)hideBackgroundLoaderViewWithAlpha;

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message titleCancel:(NSString *)titleCancel;
- (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message titleCancel:(NSString *)titleCancel;
- (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message;

@end
