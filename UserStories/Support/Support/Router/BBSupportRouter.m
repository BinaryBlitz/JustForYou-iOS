//
//  BBSupportRouter.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportRouter.h"

#import <MessageUI/MessageUI.h>

@interface BBSupportRouter() <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) MFMailComposeViewController *mailController;

@end

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
        [_mailController setToRecipients:[NSArray arrayWithObjects:@"justforyouav@gmail.com",nil]];
        [_mailController becomeFirstResponder];
    }
    return _mailController;
}

@end