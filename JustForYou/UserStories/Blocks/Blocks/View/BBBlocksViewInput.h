#import <Foundation/Foundation.h>


@protocol BBBlocksViewInput <NSObject>

- (void)setupInitialState;

- (void)blocksForTableView:(NSArray *)blocks;

- (void)showLoaderView;
- (void)hideLoaderView;

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)updateBasketButtonImageWithImageName:(NSString *)name;

@end
