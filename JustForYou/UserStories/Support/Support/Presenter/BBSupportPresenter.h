#import "BBSupportViewOutput.h"
#import "BBSupportInteractorOutput.h"
#import "BBSupportModuleInput.h"

#import <MessageUI/MessageUI.h>

@protocol BBSupportViewInput;
@protocol BBSupportInteractorInput;
@protocol BBSupportRouterInput;

@interface BBSupportPresenter : NSObject <BBSupportModuleInput, BBSupportViewOutput, BBSupportInteractorOutput>

@property (strong, nonatomic) id<BBSupportViewInput> view;
@property (strong, nonatomic) id<BBSupportInteractorInput> interactor;
@property (strong, nonatomic) id<BBSupportRouterInput> router;


- (void)errorOpenEmailController;
- (void)mailControllerDissmassWithResult:(MFMailComposeResult)result;

- (void)errorCallManager;

@end
