#import "BBDeliveryViewController.h"

#import "BBDeliveryViewOutput.h"

#import "BBCalendarMenuView.h"

@interface BBDeliveryViewController () <UITableViewDelegate, UITableViewDataSource, BBCalendarMenuViewDelegate, BBCalendarDeliveryCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BBCalendarMenuView *calendarMenu;

@property (strong, nonatomic) BBCalendarDeliveryTableViewCell *calendarCell;

@property (weak, nonatomic) BBPurchases *purchase;
@property (weak, nonatomic) BBProgram *program;
@property (strong, nonatomic) NSArray *selectionDates;

@end

static CGFloat estimatedRowHeight = 50.0f;
static CGFloat topOffset = -35.0f;

static CGFloat wightForCalendarMenuView = 140.0f;
static CGFloat heightForCalendarMenuView = 32.0f;

@implementation BBDeliveryViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
  [super viewDidLoad];
  self.selectionDates = [NSArray array];
  [self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.output viewWillAppear];
  [[BBAppAnalitics sharedService] sendControllerWithName:@"Создание заказа"];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.output viewWillDisappear];
}

- (void)_readyButtonAction:(id)sender {
  [self.output readyButtonDidTap];
}

#pragma mark - Методы BBDeliveryViewInput

- (void)setupInitialState {
  self.navigationItem.rightBarButtonItem = [self readyButton];
  [self _registerCellIdentifireInTableView];
  [self _settingTableView];
  self.navigationItem.titleView = self.calendarMenu;
}

- (void)purchaseForCalendar:(BBPurchases *)purchase program:(BBProgram *) program selectionDates:(NSArray *)days {
  self.program = program;
  self.purchase = purchase;
  self.selectionDates = days;
  HQDispatchToMainQueue(^{
    [self.tableView reloadData];
  });
}

- (NSArray *)currentSelectionDates {
  NSArray *array = self.selectionDates;
  self.selectionDates = [NSArray array];
  return array;
}

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
  self.calendarMenu.titleLabel.text = currentName;
}

- (void)currentArraySelectionDays:(NSArray *)selectionDays {
  self.selectionDates = selectionDays;
}

- (void)showAlertViewWithMessage:(NSString *)message {
  [self presentAlertControllerWithTitle:@"Внимание" message:message];
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameCalendarDeliveryCell bundle:nil]
       forCellReuseIdentifier:kCalendarDeliveryCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
       forCellReuseIdentifier:kAccessoryCellIdentifire];
}

- (void)_settingTableView {
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = estimatedRowHeight;
  self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  }
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;

  if (indexPath.section == 0) {
    BBCalendarDeliveryTableViewCell *calendarCell = [[NSBundle mainBundle] loadNibNamed:kNibNameCalendarDeliveryCell
                                                                                  owner:self options:nil].lastObject;
    calendarCell.countDayInOrder = self.purchase.countDays;
    calendarCell.isNewOrder = !self.purchase;
    self.calendarCell = calendarCell;
    [self _setDelegates];
    [calendarCell setSelectionDays:self.selectionDates];
    cell = calendarCell;
  } else {
    BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
    accessoryCell.accessoryType = UITableViewCellAccessoryNone;
    accessoryCell.setRadius = YES;
    accessoryCell.accessoryImageView.hidden = YES;
    if (indexPath.row == 0) {
      accessoryCell.kSideCornerRadius = kTopCornerRadius;
      accessoryCell.textLabel.text = @"Подряд";
    } else {
      accessoryCell.kSideCornerRadius = kBottomCornerRadius;
      accessoryCell.textLabel.text = @"Подряд без выходных";
    }
    cell = accessoryCell;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (indexPath.section == 1) {
    if (indexPath.row == 0) {
      [self.calendarCell successivelySelectedDay];
    } else {
      [self.calendarCell successivelySelectedDayWithoutWeekend];
    }
  }
}

- (void)_setDelegates {
  self.calendarCell.delegate = self;
  self.delegate = self.calendarCell;
}

#pragma mark - BBCalendarMenuViewDelegate

- (void)leftButtonDidTap {
  [self.delegate leftCalendarMenuButtonDidTap];
}

- (void)rightButtonDidTap {
  [self.delegate rightCalendarMenuButtonDidTap];
}

#pragma mark - Lazy Load

- (BBCalendarMenuView *)calendarMenu {
  if (!_calendarMenu) {
    _calendarMenu = [[BBCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, wightForCalendarMenuView, heightForCalendarMenuView)];
    _calendarMenu.delegate = self;
  }
  return _calendarMenu;
}

- (UIBarButtonItem *)readyButton {
  UIBarButtonItem *ready = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(_readyButtonAction:)];
  ready.tintColor = [UIColor blackColor];
  return ready;
}


@end
