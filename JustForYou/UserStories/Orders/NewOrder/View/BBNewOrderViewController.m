#import "BBNewOrderViewController.h"

#import "BBNewOrderViewOutput.h"

@interface BBNewOrderViewController () <UITableViewDataSource, UITableViewDelegate, BBCommentTableViewCellDelegate, BBTimeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *toOrderButton;

@property (strong, nonatomic) BBCommentTableViewCell *commentCell;
@property (strong, nonatomic) BBAccessoryTableViewCell *adressCell;
@property (strong, nonatomic) BBTimeTableViewCell *timeCell;

@property (strong, nonatomic) BBPurchases *purchase;
@property (strong, nonatomic) BBProgram *program;
@property (strong, nonatomic) BBOrderProgram *orderProgram;
@property (assign, nonatomic) NSInteger selectionDaysCount;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *currentComment;
@property (assign, nonatomic) BOOL isConfigured;

@end

static CGFloat estimatedHeightCell = 44.0f;
static CGFloat heightForHeaderSection = 45.0f;
static CGFloat topInsetForTableView = -35.0f;

BOOL isEditing = NO;

@implementation BBNewOrderViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.output didTriggerViewReadyEvent];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.tableView reloadData];
  [self.output viewWillAppear];
  [[BBAppAnalitics sharedService] sendControllerWithName:kNameTitleNewOrderModule];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  [self _layoutToOrderButton];
}

#pragma mark - Actions Methods

- (IBAction)toOrderButtonAction:(id)sender {
  [self.timeCell startHourAndMinute];
}

- (void)_resignFirstResponderWithTap {
  [self.commentCell.textView resignFirstResponder];
}

#pragma mark - BBCommentTableViewCellDelegate

- (void)commentDidChange:(NSString *)comment {
  self.currentComment = comment;
}

#pragma mark - Методы BBNewOrderViewInput

- (void)setupInitialState {
  [self _settingsTableViewAndRegisterNib];
  self.address = @"";
  self.currentComment = @"";
  self.navigationItem.title = kNameTitleNewOrderModule;
  [self _registerNotificationKeyboard];
  self.isConfigured = NO;
}

- (void)deleteAddress {
  self.address = @"";
  self.currentComment = @"";
}

- (void)countsDaysInCalendar:(NSInteger)counts {
  self.selectionDaysCount = counts;
}

- (void)purchaseWithPurchase:(BBPurchases *)purchase {
  self.purchase = purchase;
  HQDispatchToMainQueue(^{
    [self.tableView reloadData];
  });
}

- (void)popViewController {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)programWithProgram:(BBProgram *)program {
  self.program = program;
  HQDispatchToMainQueue(^{
    [self.tableView reloadData];
  });
}

- (void)orderProgramWithProgram:(BBOrderProgram *)orderProgram program:(BBProgram *)program {
  if (self.orderProgram != orderProgram) {
    self.isConfigured = NO;
  }
  self.program = program;
  self.orderProgram = orderProgram;
  self.selectionDaysCount = orderProgram.days.count;
  self.address = orderProgram.address.street;
  self.currentComment = orderProgram.commentOrder;
  [self.tableView reloadData];
  [self.tableView layoutIfNeeded];
  self.isConfigured = YES;
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
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardDidHide:)
                                               name:UIKeyboardDidHideNotification
                                             object:nil];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_resignFirstResponderWithTap)];
  tap.cancelsTouchesInView = NO;
  [self.tableView addGestureRecognizer:tap];
}

- (void)adressForAdressTableViewCell:(NSString *)adress {
  self.address = adress;
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
  [self presentAlertControllerWithTitle:title message:message];
}

- (void)presentFinishAlertWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertController *alert = [self alertControllerWithTitle:title message:message];
  UIAlertAction *action = [UIAlertAction actionWithTitle:kNextButton style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action) {
    [self.output alertOkDidTap];
  }];
  [alert addAction:action];
  HQDispatchToMainQueue(^{
    [self presentViewController:alert animated:YES completion:nil];
  });
}

#pragma mark - TableView Methods

- (void)_settingsTableViewAndRegisterNib {
  self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = estimatedHeightCell;
  self.tableView.contentInset = UIEdgeInsetsMake(topInsetForTableView, 0, 0, 0);
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameMyProgramCell bundle:nil] forCellReuseIdentifier:kMyProgramCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil] forCellReuseIdentifier:kAccessoryCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameCommentCell bundle:nil] forCellReuseIdentifier:kCommentCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameTimeCell bundle:nil] forCellReuseIdentifier:kTimeCellIdentifire];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 1) {
    return 3;
  }
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  }
  return heightForHeaderSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return @"";
  } else if (section == 1) {
    return @"ДОСТАВКА";
  }
  return @"КОММЕНТАРИЙ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  if (indexPath.section == 0) {
    BBMyProgramTableViewCell *myProgramCell = [self.tableView dequeueReusableCellWithIdentifier:kMyProgramCellIdentifire];
    if (self.purchase) {
      myProgramCell.purchases = self.purchase;
    } else {
      myProgramCell.program = self.program;
      [myProgramCell setDaysCount:self.selectionDaysCount];
    }
    cell = myProgramCell;
  } else if (indexPath.section == 1) {
    if (indexPath.row == 0) {
      BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
      accessoryCell.textLabel.text = @"Количество дней";
      accessoryCell.countLabel.hidden = NO;
      accessoryCell.countLabel.text = [NSString stringWithFormat:@"%ld", (long) self.selectionDaysCount];
      accessoryCell.setRadius = YES;
      accessoryCell.kSideCornerRadius = kTopCornerRadius;
      cell = accessoryCell;
    } else if (indexPath.row == 1) {
      BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
      if (![self.address isEqualToString:@""] && ![self.address isEqualToString:@" "]) {
        accessoryCell.textLabel.text = self.address;
      } else {
        accessoryCell.textLabel.text = @"Адрес";
      }
//            accessoryCell.setRadius = YES;
//            accessoryCell.kSideCornerRadius = kNoneCornerRadius;
      self.adressCell = accessoryCell;
      cell = accessoryCell;
    } else {
      BBTimeTableViewCell *timeCell = [self.tableView dequeueReusableCellWithIdentifier:kTimeCellIdentifire];
      timeCell.delegate = self;
      if (!self.isConfigured && self.orderProgram) {
        [timeCell setStartHour:self.orderProgram.hour minute:self.orderProgram.minute];
      }
      self.timeCell = timeCell;
      cell = timeCell;
    }
  } else {
    BBCommentTableViewCell *commentCell = [[NSBundle mainBundle] loadNibNamed:kNibNameCommentCell owner:self options:nil].lastObject;
    self.commentCell = commentCell;
    if (!self.isConfigured && self.currentComment) {
      [commentCell setComment:self.currentComment];
    }
    commentCell.delegate = self;
    cell = commentCell;
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 2) {
    //self.commentCell = (BBCommentTableViewCell *) cell;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (isEditing) {
    return;
  }
  if (indexPath.section == 1) {
    if (indexPath.row == 0) {
      [self.output countDayCellDidTap];
    } else if (indexPath.row == 1) {
      [self.output adresCellDidTap];
    }
  }
}

#pragma mark - Notification Methods

- (void)keyboardWillShow:(NSNotification *)notification {
  isEditing = YES;
  NSDictionary *info = [notification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);

  self.tableView.contentInset = contentInsets;
  self.tableView.scrollIndicatorInsets = contentInsets;
  [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:self.commentCell]
                        atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
  self.tableView.contentInset = UIEdgeInsetsMake(topInsetForTableView, 0, 0, 0);
  [self.tableView setContentOffset:CGPointMake(0, -topInsetForTableView) animated:YES];
}

- (void)keyboardDidHide:(NSNotification *)notification {
  isEditing = NO;
}

- (void)presentAlertForMessage:(NSString *)message {
  [self presentAlertWithTitle:kNoteTitle message:message];
}

- (void)startHour:(NSInteger)startHour startMinute:(NSInteger)startMinute {
  [self.output toOrderButtonDidTapWithComment:self.currentComment startHour:startHour startMinute:startMinute];
}

#pragma mark - Layout Methods

- (void)_layoutToOrderButton {
  self.toOrderButton.layer.masksToBounds = YES;
  self.toOrderButton.layer.cornerRadius = CGRectGetHeight(self.toOrderButton.frame) / 2;
}

@end
