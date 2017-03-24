#import <Foundation/Foundation.h>

@protocol BBAuthorizationViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)nextButtonDidPress;

- (void)backButtonDidTap;

- (void)codeUser:(NSString *)code;

- (void)authorizedDidFinishAnimation;

- (void)sendCodeButtonDidTapWithValidField:(BOOL)valid andNumberPhone:(NSString *)primaryNumber;

- (void)sengAgainButtonDidTap;

@end
