#import <Foundation/Foundation.h>

@protocol BBTabbarViewInput <NSObject>

- (void)setupInitialState;

- (void)setItemsBar:(NSArray *)items;

- (void)presentFirstItem;

@end
