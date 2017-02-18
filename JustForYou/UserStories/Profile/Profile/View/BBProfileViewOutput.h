#import <Foundation/Foundation.h>

@protocol BBProfileViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)settingsButtonDidTap;

- (void)didSelectRowForKeyModule:(BBKeyModuleForUniversalModule)key;

- (void)viewWillAppear;

@end
