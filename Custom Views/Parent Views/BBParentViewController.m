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
@property (strong, nonatomic) UIView *backGroungView;
@property (strong, nonatomic) BBLoaderView *backgroungLoaderView;

@property (nonatomic) BOOL badConstant;

@end

CGFloat sizeLoader = 50.0f;
CGFloat sizeBar = 44.0f;

@implementation BBParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.badConstant = YES;
    
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

- (void)showBackgroundLoaderView {
    if (self.badConstant) {
        [self.view addSubview:self.backGroungView];
        self.badConstant = NO;
    }
    HQDispatchToMainQueue(^{
        self.backGroungView.hidden = NO;
        [self.backgroungLoaderView.activityIndicator startAnimating];
    });
}

- (void)hideBackgroundLoaderView {
    HQDispatchToMainQueue(^{
        self.backGroungView.hidden = YES;
        [self.backgroungLoaderView.activityIndicator stopAnimating];
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

- (BBLoaderView *)backgroungLoaderView {
    if (!_backgroungLoaderView) {
        _backgroungLoaderView = [[BBLoaderView alloc] initWithFrame:CGRectMake(0, 0, sizeLoader, sizeLoader)];
    }
    return _backgroungLoaderView;
}

- (UIView *)backGroungView {
    if (!_backGroungView) {
        _backGroungView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _backGroungView.backgroundColor = [BBConstantAndColor applicationWhiteBackgroundColor];
        [_backGroungView addSubview:self.backgroungLoaderView];
        self.backgroungLoaderView.center = _backGroungView.center;
    }
    return _backGroungView;
}

@end
