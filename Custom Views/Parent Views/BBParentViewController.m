//
//  BBParentViewController.m
//  JustForYou
//
//  Created by Антон on 28.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBParentViewController.h"

@interface BBParentViewController ()

@property (strong, nonatomic) UIAlertAction *cancelAction;

@end

CGFloat sizeLoader = 50.0f;
CGFloat sizeBar = 44.0f;

@implementation BBParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _settingLoaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Init Methods

- (void)_settingLoaderView {
    [self.view addSubview:self.loaderView];
    [self _layoutLoadView];
    self.loaderView.hidden = YES;
}

#pragma mark - LoaderView Methods

- (void)showLoaderView {
    HQDispatchToMainQueue(^{
        self.loaderView.hidden = NO;
        [self.loaderView.activityIndicator startAnimating];
    });
}

- (void)hideLoaderView {
    HQDispatchToMainQueue(^{
        self.loaderView.hidden = YES;
        [self.loaderView.activityIndicator stopAnimating];
    });
}

#pragma mark - AlertController Methods

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    self.alertController.title = title;
    self.alertController.message = message;
    HQDispatchToMainQueue(^{
        [self presentViewController:self.alertController animated:YES completion:nil];
        self.alertController.view.tintColor = [BBConstantAndColor applicationOrangeColor];
    });
}

#pragma mark - Layout Views

- (void)_layoutLoadView {
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    NSLog(@"%@", NSStringFromCGRect(mainScreen));
    self.loaderView.center = CGPointMake(CGRectGetMidX(mainScreen), CGRectGetMidY(mainScreen) - sizeBar);
}

#pragma mark - Lazy Load

- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [_alertController addAction:self.cancelAction];
        _alertController.view.tintColor = [BBConstantAndColor applicationOrangeColor];
    }
    return _alertController;
}

- (UIAlertAction *)cancelAction {
    if (!_cancelAction) {
        _cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _cancelAction;
}

- (BBLoaderView *)loaderView {
    if (!_loaderView) {
        _loaderView = [[BBLoaderView alloc] initWithFrame:CGRectMake(0, 0, sizeLoader, sizeLoader)];
    }
    return _loaderView;
}
@end
