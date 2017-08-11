#import "BBSupportRouter.h"

@interface BBSupportRouter () <MFMailComposeViewControllerDelegate>

@end

static NSString *mailForSupport = @"info@justforyou.ru";

@implementation BBSupportRouter

#pragma mark - BBSupportRouterInput

- (void)callManagerOnPhone:(NSString *)phoneManager {
  NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phoneManager]];
  if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
    [[UIApplication sharedApplication] openURL:phoneUrl];
  } else {
    [self.presenter errorCallManager];
  }
}

- (void)presentMailController {
  UIViewController *vc = (UIViewController *) self.presenter.view;
  if ([MFMailComposeViewController canSendMail]) {
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = self;
    [mailController setSubject:@"iOS Приложение"];
    [mailController setMessageBody:@"" isHTML:YES];
    [mailController setToRecipients:[NSArray arrayWithObjects:mailForSupport, nil]];
    [mailController becomeFirstResponder];

    HQDispatchToMainQueue(^{
      [vc presentViewController:mailController animated:YES completion:^(void) {
      }];
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

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
  HQDispatchToMainQueue(^{
    [controller dismissViewControllerAnimated:YES completion:^{
      [self.presenter mailControllerDissmassWithResult:result];
    }];
  });
}

@end
