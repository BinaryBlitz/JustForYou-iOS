#import "BBSupportRouter.h"

#import <MessageUI/MessageUI.h>

@interface BBSupportRouter() <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) MFMailComposeViewController *mailController;

@end

static NSString *mailForSupport = @"info@justforyou.ru";

@implementation BBSupportRouter

#pragma mark - BBSupportRouterInput

- (void)callManagerOnPhone:(NSString *)phoneManager {
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@", phoneManager]];
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else {
        [self.presenter errorCallManager];
    }
}

- (void)presentMailController {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    if ([MFMailComposeViewController canSendMail]) {
        HQDispatchToMainQueue(^{
            [vc presentViewController:self.mailController animated:YES completion:^(void){}];
        });
    } else {
        [self.presenter errorOpenEmailController];
    }
}

- (void)presentITunseWithAppUrl:(NSString *)appURL {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURL]];
}

- (void)openFacebookSocialGroup {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kFacebookSocialGroup]];
}

- (void)openInstagamSocialGroup {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kInstagramSocialGroup]];
}


#pragma mark - MailController Delegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    UIViewController *vc = (UIViewController *)self.presenter.view;
    HQDispatchToMainQueue(^{
        [vc dismissViewControllerAnimated:YES completion:^{
            [self.presenter mailControllerDissmassWithResult:result];
        }];
    });
}

#pragma mark - Lazy Load

- (MFMailComposeViewController *)mailController {
    if (!_mailController) {
        _mailController = [[MFMailComposeViewController alloc] init];
        _mailController.mailComposeDelegate = self;
        [_mailController setSubject:@"iOS Приложение"];
        [_mailController setMessageBody:@"" isHTML:YES];
        [_mailController setToRecipients:[NSArray arrayWithObjects:mailForSupport, nil]];
        [_mailController becomeFirstResponder];
    }
    return _mailController;
}

@end
