#import <Foundation/Foundation.h>

@protocol BBSettingsViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;
- (void)viewWillDisappear;

- (void)logoutButtonDidTap;

- (void)didSelectRowForKeyModule:(BBKeyModuleForUniversalModule)key;

@end
