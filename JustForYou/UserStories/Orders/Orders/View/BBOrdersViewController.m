#import "BBOrdersViewController.h"

#import "BBOrdersViewOutput.h"

#import "BBCalendarMenuView.h"
#import "BBTableAlertController.h"

@interface BBOrdersViewController () <BBCalendarMenuViewDelegate, UITableViewDelegate, UITableViewDataSource, BBCalendarTableViewCellDelegate, BBTableAlertControllerDelegate, BBPreviewOrderCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) BBCalendarMenuView *calendarMenu;

@property (strong, nonatomic) BBCalendarTableViewCell *calendarCell;

@property (strong, nonatomic) NSArray *deliveriesArray;
@property (strong, nonatomic) NSArray *ordersArray;
@property (strong, nonatomic) NSMutableArray *ordersId;

@end

static CGFloat wightForCalendarMenuView = 140.0f;
static CGFloat heightForCalendarMenuView = 32.0f;
static CGFloat estimatedRowHeight = 100.0f;

@implementation BBOrdersViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.output viewWillAppear];
  [[BBAppAnalitics sharedService] sendControllerWithName:@"Заказы"];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

#pragma mark - Методы BBOrdersViewInput

- (void)setupInitialState {
  [self _registerNibWithIdentifireCell];
  [self _settingTableView];
  self.navigationItem.titleView = self.calendarMenu;
}

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
  self.calendarMenu.titleLabel.text = currentName;
}

- (void)updateDeliveriesWithArray:(NSArray *)deliveries {
  self.deliveriesArray = deliveries;
  NSMutableArray *array = [NSMutableArray array];
  for (BBOrder *order in self.deliveriesArray) {
    for (NSNumber *number in self.ordersId) {
      NSInteger orderId = [number integerValue];
      if (orderId == order.orderId) {
        [array addObject:order];
      }
    }
  }
  self.ordersArray = array;
  HQDispatchToMainQueue(^{
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:YES];
  });
}

- (void)clearOrdersArrayWithOrder:(BBOrder *)order {
  NSMutableArray *array = [NSMutableArray arrayWithArray:self.ordersArray];
  [array removeObject:order];
  self.ordersArray = array;
  self.ordersId = [NSMutableArray array];
  for (BBOrder *order in self.ordersArray) {
    NSNumber *number = [NSNumber numberWithInteger:order.orderId];
    [self.ordersId addObject:number];
  }
  HQDispatchToMainQueue(^{
    NSRange range = NSMakeRange(1, 1);
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:range] withRowAnimation:UITableViewRowAnimationNone];
  });
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
  [self presentAlertControllerWithTitle:title message:message];
}

#pragma mark - TableView Methods

- (void)_registerNibWithIdentifireCell {
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameCalendarCell bundle:nil] forCellReuseIdentifier:kCalendarCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNamePreviewOrderCell bundle:nil] forCellReuseIdentifier:kPreviewOrderCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameClearOrderCell bundle:nil] forCellReuseIdentifier:kClearOrderCellIdentifire];
}

- (void)_settingTableView {
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = estimatedRowHeight;
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
  self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  }
  if ([self.ordersArray count] > 0) {
    return [self.ordersArray count];
  }
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  if (indexPath.section == 0) {
    BBCalendarTableViewCell *calendarCell = [self.tableView dequeueReusableCellWithIdentifier:kCalendarCellIdentifire];
    calendarCell.ordersForCalendar = self.deliveriesArray;
    self.calendarCell = calendarCell;
    [self _setDelegates];
    cell = calendarCell;
  } else {
    if ([self.ordersArray count] > 0) {
      BBPreviewOrderTableViewCell *previewCell = [[NSBundle mainBundle] loadNibNamed:kNibNamePreviewOrderCell owner:self options:nil].lastObject;
      if ([self.ordersArray count] > 0) {
        previewCell.order = [self.ordersArray objectAtIndex:indexPath.row];
      }
      previewCell.delegate = self;
      cell = previewCell;
    } else {
      BBClearOrderTableViewCell *clearCell = [[NSBundle mainBundle] loadNibNamed:kNibNameClearOrderCell owner:self options:nil].lastObject;
      cell = clearCell;
    }
  }

  return cell;
}

- (void)_setDelegates {
  self.calendarCell.delegate = self;
  self.delegate = self.calendarCell;
}

#pragma mark - BBCalendarTableViewCellDelegate 

- (void)dayViewDidTapWithOrders:(NSArray *)orders {
  NSMutableArray *array = [NSMutableArray array];
  for (BBOrder *order in orders) {
    if (![order isInvalidated]) {
      [array addObject:order];
    }
  }
  self.ordersArray = array;
//    if ([self.ordersArray count] > 0) {
  NSRange range = NSMakeRange(1, 1);
  [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:range] withRowAnimation:UITableViewRowAnimationNone];
//    }
}

- (void)addNewOrderButtonDidTap {
  [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"oformit_dostavky" action:@"click" label:@""];
  [self.output addNewOrderButtonDidTap];
}

#pragma mark - BBCalendarMenuViewDelegate

- (void)leftButtonDidTap {
  [self.delegate leftCalendarMenuButtonDidTap];
}

- (void)rightButtonDidTap {
  [self.delegate rightCalendarMenuButtonDidTap];
}

#pragma mark - TableAlert Methods

- (void)createAndPresentTableAlertWithMessage:(NSString *)message {
  BBTableAlertController *alert = [BBTableAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
  alert.delegate = self;
  HQDispatchToMainQueue(^{
    [self presentViewController:alert animated:YES completion:nil];
    alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
  });
}

- (void)cellDidSelectWithPayCard:(BBPayCard *)card {
  [self.output payCardWithCard:card];
}

- (void)payNewCardDidTap {
  [self.output payNewCardButtonDidTap];
}

- (void)cancelButtonDidTap {
  [self.output cancelButtonDidTap];
}

- (void)deleteButtonDidTapWithOrder:(BBOrder *)order {
  [self.output deleteButtonDidTapWithOrder:order];
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message
                            titleAction:(NSString *)titleAction cancelTitle:(NSString *)cancel key:(BBKeyForOkButtonAlert)key {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *ok = [UIAlertAction actionWithTitle:titleAction style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    [self.output okCancelButtonDidTapWithKey:key];
  }];
  if (cancel) {
    UIAlertAction *canc = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
      [self.output okCancelButtonDidTapWithKey:kPayCancelButton];
    }];
    [alert addAction:canc];
  }
  alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
  [alert addAction:ok];
  HQDispatchToMainQueue(^{
    [self presentViewController:alert animated:YES completion:nil];
    alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
  });
}

#pragma mark - Lazy Load

- (BBCalendarMenuView *)calendarMenu {
  if (!_calendarMenu) {
    _calendarMenu = [[BBCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, wightForCalendarMenuView, heightForCalendarMenuView)];
    _calendarMenu.delegate = self;
  }
  return _calendarMenu;
}

- (NSArray *)ordersArray {
  if (!_ordersArray) {
    _ordersArray = [NSArray array];
  }
  return _ordersArray;
}

@end
