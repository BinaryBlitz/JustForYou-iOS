

@interface BBParentViewController ()

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

- (void)showBackgroundLoaderViewWithAlpha:(CGFloat)alpha {
  if (self.badConstant) {
    [self.view addSubview:self.backGroungView];
    self.badConstant = NO;
  }
  HQDispatchToMainQueue(^{
    self.backGroungView.hidden = NO;
    [self.backGroungView setBackgroundColor:[self.backGroungView.backgroundColor colorWithAlphaComponent:alpha]];
    self.backGroungView.alpha = alpha;
    [self.backgroungLoaderView.activityIndicator startAnimating];
  });
}

- (void)hideBackgroundLoaderViewWithAlpha {
  HQDispatchToMainQueue(^{
    self.backGroungView.hidden = YES;
    self.backGroungView.alpha = 1.0f;
    [self.backgroungLoaderView.activityIndicator stopAnimating];
  });
}

#pragma mark - AlertController Methods

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertController *alertController = [self _alertController];
  alertController.title = title;
  alertController.message = message;
  UIAlertAction *action = [self _cancelActionWithTitle:kNextButton];
  [alertController addAction:action];
  HQDispatchToMainQueue(^{
    [self presentViewController:alertController animated:YES completion:nil];
    alertController.view.tintColor = [BBConstantAndColor applicationOrangeColor];
  });
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message titleCancel:(NSString *)titleCancel {
  UIAlertController *alertController = [self _alertController];
  alertController.title = title;
  alertController.message = message;
  UIAlertAction *action = [self _cancelActionWithTitle:titleCancel];
  [alertController addAction:action];
  HQDispatchToMainQueue(^{
    [self presentViewController:alertController animated:YES completion:nil];
    alertController.view.tintColor = [BBConstantAndColor applicationOrangeColor];
  });
}

- (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message titleCancel:(NSString *)titleCancel {
  UIAlertController *alertController = [self _alertController];
  alertController.title = title;
  alertController.message = message;
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:titleCancel
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *_Nonnull action) {
                                                       }];

  [alertController addAction:cancelAction];
  return alertController;
}

- (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertController *alertController = [self _alertController];
  alertController.title = title;
  alertController.message = message;
  return alertController;
}

#pragma mark - Init Alert Methods

- (UIAlertController *)_alertController {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                           message:@""
                                                                    preferredStyle:UIAlertControllerStyleAlert];
  alertController.view.tintColor = [BBConstantAndColor applicationOrangeColor];
  return alertController;
}

- (UIAlertAction *)_cancelActionWithTitle:(NSString *)title {
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *_Nonnull action) {
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                       }];
  return cancelAction;
}

#pragma mark - Layout Views

#pragma mark - Lazy Load

- (BBLoaderView *)loaderView {
  if (!_loaderView) {
    _loaderView = [[BBLoaderView alloc] initWithFrame:CGRectMake(0, 0, sizeLoader, sizeLoader)];
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    self.loaderView.center = CGPointMake(CGRectGetMidX(mainScreen), CGRectGetMidY(mainScreen) - sizeBar);
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
