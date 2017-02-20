#import <Foundation/Foundation.h>

@protocol BBPaymentViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)webViewDidChangeURLWithURL:(NSURL *)url;

@end
