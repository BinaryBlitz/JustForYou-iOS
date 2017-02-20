#import <Foundation/Foundation.h>

#import "BBProgram.h"

@protocol BBCardProgramViewInput <NSObject>

- (void)setupInitialState;

- (void)updateViewWithProgram:(NSInteger)parentId;

- (void)changeImageAndPresentAlertControllerWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle;

- (void)showAddInBasketPopover;

- (void)showLoaderView;
- (void)hideLoaderView;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)updateBasketButtonImageWithImageName:(NSString *)name;

@end
