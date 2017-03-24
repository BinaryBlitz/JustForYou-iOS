#import "BBAuthorizationViewController.h"

#import "BBAuthorizationViewOutput.h"
#import "BBUserService.h"

@interface BBAuthorizationViewController () <UITableViewDelegate, UITableViewDataSource, BBInfoRegistrateCellDelegate, BBNumberCellDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *youView;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topYouViewConstraint;

@property (strong, nonatomic) UIBarButtonItem *backBarButton;

@property (nonatomic) BBKeyStyleTableViewRegist keyStyleTableView;
@property (strong, nonatomic) NSString *numberPhone;

@property (weak, nonatomic) BBNumberPhoneTableViewCell *numberCell;
@property (weak, nonatomic) BBTextTableViewCell *textCell;

@end

static NSString *kTextForSendCode = @"Введите код:";
static NSString *kTextForEnterPhone = @"Введите ваш номер телефона:";
static NSString *kTextForInfoLabel = @"Код отправлен на ";

static CGFloat estimateRowHeight = 44.0f;
static CGFloat offsetBottom = 10.0f;

static CGFloat movingAnimationTime = 3.0f;

@implementation BBAuthorizationViewController

BOOL didLayoutAnimated = NO;

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
  [super viewDidLoad];

  self.keyStyleTableView = kNumberPhoneStyleTableView;

  [self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.output viewWillAppear];
  [self layoutAnimatedIfNeeded];
  [[BBAppAnalitics sharedService] sendControllerWithName:kNameTitleAuthorizateModule];
}

- (void)layoutAnimatedIfNeeded {
  if (didLayoutAnimated == YES) {return;}
  didLayoutAnimated = NO;
  [self layoutYouView];
  [self hideTableView];

  CGFloat topViewConstraintConstant = self.topYouViewConstraint.constant;
  self.topYouViewConstraint.constant = self.view.frame.size.height;
  [self.view layoutIfNeeded];
  [UIView animateWithDuration:movingAnimationTime animations:^{
    self.topYouViewConstraint.constant = topViewConstraintConstant;
    [self.view layoutIfNeeded];
  }                completion:^(BOOL finished) {
    BBUser *user = [[BBUserService sharedService] currentUser];
    if (user) {
      [self.output authorizedDidFinishAnimation];
    } else {
      [self showTableView];
    }
  }];
}

- (void)hideTableView {
  self.informationLabel.alpha = 0;
  self.tableView.alpha = 0;
}

- (void)showTableView {
  [UIView animateWithDuration:animateTime animations:^{
    self.informationLabel.alpha = 1;
    self.tableView.alpha = 1;
    [self.view layoutIfNeeded];
  }];
}

- (void)_registerNotificationKeyboard {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_resignFirstResponderWithTap)];
  [self.scrollView addGestureRecognizer:tap];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Методы BBAuthorizationViewInput

- (void)setupInitialState {
  self.navigationItem.title = kNameTitleAuthorizateModule;
  self.numberPhone = @"";
  [self _registrateIdentifireCell];
  [self _registerNotificationKeyboard];
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
  [self presentAlertControllerWithTitle:title message:message];
}

- (void)keyForTableView:(BBKeyStyleTableViewRegist)key {
  self.keyStyleTableView = key;
  HQDispatchToMainQueue(^{
    if (key == kSendCodeStyleTableView) {
      self.navigationItem.leftBarButtonItem = self.backBarButton;
      self.informationLabel.text = kTextForSendCode;
    } else {
      self.navigationItem.leftBarButtonItem = nil;
      self.navigationItem.rightBarButtonItem = nil;
      self.informationLabel.text = kTextForEnterPhone;
    }
    [self.tableView reloadData];
  });
}

- (void)updateTableViewWithKeyTableView:(BBKeyStyleTableViewRegist)key {
  self.keyStyleTableView = key;
  HQDispatchToMainQueue(^{
    if (key == kSendCodeStyleTableView) {
      self.navigationItem.leftBarButtonItem = self.backBarButton;
      self.informationLabel.text = kTextForSendCode;
    } else {
      self.navigationItem.leftBarButtonItem = nil;
      self.navigationItem.rightBarButtonItem = nil;
      self.informationLabel.text = kTextForEnterPhone;
    }
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    [self.tableView endUpdates];
  });
}

- (void)getCodeUser {
  [self _resignFirstResponderWithTap];
  [self.output codeUser:self.textCell.textField.text];
}

#pragma mark - Actions Methods

- (void)_resignFirstResponderWithTap {
  [self.numberCell.numberTextField resignFirstResponder];
  [self.textCell.textField resignFirstResponder];
}

- (void)_backBarButtonAction {
  [self.output backButtonDidTap];
}

#pragma mark - Cell Delegate Methods

- (void)sengAgainButtonDidTap {
  [self.output sengAgainButtonDidTap];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  BBInfoRegistTableViewCell *infoCell = [[NSBundle mainBundle] loadNibNamed:kNibNameInfoRegistCell
                                                                      owner:self options:nil].lastObject;
  infoCell.delegate = self;
  if (self.keyStyleTableView == kNumberPhoneStyleTableView) {
    if (indexPath.row == 0) {
      BBNumberPhoneTableViewCell *numberCell = [[NSBundle mainBundle] loadNibNamed:kNibNameNumberPhoneCell owner:self options:nil].lastObject;
      numberCell.delegate = self;
      self.numberCell = numberCell;
      numberCell.numberTextField.text = @"";
      cell = numberCell;
    } else {
      infoCell.keyStyleCell = kBigInfoRegistCellStyle;
      cell = infoCell;
    }
  } else {
    if (indexPath.row == 0) {
      BBTextTableViewCell *textCell = [self.tableView dequeueReusableCellWithIdentifier:kTextFieldCellIdentifire];
      textCell.textField.textAlignment = NSTextAlignmentCenter;
      textCell.textField.keyboardType = UIKeyboardTypeNumberPad;
      textCell.textField.placeholder = @"1234";
      textCell.textField.delegate = self;
      self.textCell = textCell;
      textCell.textField.text = @"";
      cell = textCell;
    } else {
      infoCell.keyStyleCell = kFinishRegistCellStyle;
      infoCell.infoLabel.text = [NSString stringWithFormat:@"%@%@", kTextForInfoLabel, self.numberPhone];
      cell = infoCell;
    }
  }
  return cell;
}

- (void)_registrateIdentifireCell {
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameNumberPhoneCell bundle:nil]
       forCellReuseIdentifier:kNumberCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameTextCell bundle:nil]
       forCellReuseIdentifier:kTextFieldCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameInfoRegistCell bundle:nil]
       forCellReuseIdentifier:kInfoRegistCellIdentifire];
}

- (void)_settingsTableView {
  self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = estimateRowHeight;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (self.keyStyleTableView == kNumberPhoneStyleTableView) {
    [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"phone" action:@"field" label:@""];
  } else {
    [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"code" action:@"field" label:@""];
  }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  if (textField.text.length == 3 && ![string isEqualToString:@""]) {
    textField.text = [NSString stringWithFormat:@"%@%@", textField.text, string];
    [self.output nextButtonDidPress];
  }
  return YES;
}

#pragma mark - Notification Methods

- (void)keyboardWillShow:(NSNotification *)notification {
  NSDictionary *info = [notification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

  CGFloat contentOffsetY = -1 * (CGRectGetHeight(self.view.frame) - kbSize.height - CGRectGetMaxY(self.tableView.frame) - offsetBottom);
  [self.scrollView setContentOffset:CGPointMake(0, contentOffsetY) animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
  [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)numberPhoneValidate {
  [self.numberCell.numberTextField resignFirstResponder];
  self.numberPhone = self.numberCell.numberTextField.text;
  [self.output sendCodeButtonDidTapWithValidField:self.numberCell.validationOk andNumberPhone:self.numberPhone];
}

#pragma mark - Layout Views

- (void)layoutYouView {
  self.youView.layer.masksToBounds = YES;
  [self.youView.layer setCornerRadius:CGRectGetHeight(self.youView.frame) / 2];
}

- (UIBarButtonItem *)backBarButton {
  if (!_backBarButton) {
    _backBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(_backBarButtonAction)];
  }
  return _backBarButton;
}

@end
