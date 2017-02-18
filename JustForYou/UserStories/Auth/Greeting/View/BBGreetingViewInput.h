#import <Foundation/Foundation.h>

@protocol BBGreetingViewInput <NSObject>

- (void)setupInitialState;

- (void)countPageInPageControl:(NSInteger)count;

- (void)changePageInScrollView;

@end
