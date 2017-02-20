#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

@protocol BBProgramsViewInput <NSObject>

- (void)setupInitialState;

- (void)programsForTableView:(NSArray *)programs;

- (void)showBackgroundLoaderView;
- (void)hideBackgroundLoaderView;
- (void)showAddToBasketPopover:(BBProgram *)program;
- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)changeImageAndPresentAlertControllerWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle;

- (void)updateBasketButtonImageWithImageName:(NSString *)name;

@end
