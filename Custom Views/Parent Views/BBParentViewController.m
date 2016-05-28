//
//  BBParentViewController.m
//  JustForYou
//
//  Created by Антон on 28.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBParentViewController.h"

@interface BBParentViewController ()

@end

@implementation BBParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message withCancelActionTitle:(NSString *)cancelTitle {
    [self _createCancelActionForAlertControllerWithTitle:cancelTitle];
    self.alertController.title = title;
    self.alertController.message = message;
    HQDispatchToMainQueue(^{
        [self presentViewController:self.alertController animated:YES completion:nil];
        self.alertController.view.tintColor = [BBConstantAndColor applicationOrangeColor];
    });
}

- (void)_createCancelActionForAlertControllerWithTitle:(NSString *)title {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.alertController addAction:action];
}

#pragma mark - Lazy Load

- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        _alertController.view.tintColor = [BBConstantAndColor applicationOrangeColor];
    }
    return _alertController;
}

@end
