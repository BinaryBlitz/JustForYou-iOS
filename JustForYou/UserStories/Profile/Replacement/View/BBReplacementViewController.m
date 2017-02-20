#import "BBReplacementViewController.h"

#import "BBReplacementViewOutput.h"

@interface BBReplacementViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIBarButtonItem *rightBarButton;

@property (assign, nonatomic) BBTypeReplacementController kType;

@property (strong, nonatomic) NSArray *replacement;
@property (strong, nonatomic) NSArray *category;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (nonatomic) NSUInteger countCell;

@end

static CGFloat estimatedRowHeight = 50.0f;
static CGFloat contentInset = 20.0f;
static CGFloat heightFirstHeaderSection = 1.0f;
static CGFloat heightHeaderSection = 10.0f;
//static CGFloat heightFooterSection = 10.0f;

static NSString *infoText = @"На данном экране вы можете выбрать до трех продуктов, которые вы не употребляете";

@implementation BBReplacementViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:YES];
  [self.output viewWillAppear];
  [[BBAppAnalitics sharedService] sendControllerWithName:kNameTitleReplacementModule];
}

#pragma mark - Actions Methods

- (void)_addBarButtonAction {
  [self.output addBarButtonDidTap];
}

#pragma mark - Методы BBReplacementViewInput

- (void)typeForController:(BBTypeReplacementController)type {
  self.kType = type;
}

- (void)setupInitialState {
  self.navigationItem.title = kNameTitleReplacementModule;
  if (self.kType == kViewReplacementType) {
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
  }
  [self _registerCellIdentifireInTableView];
  [self _settingTableView];
}

- (NSInteger)countReplacementInTableView {
  return [self.replacement count];
}

- (void)currentReplacementArray:(NSArray *)replacement {
  [self _setNewReplasement:replacement];
  HQDispatchToMainQueue(^{
    [self.tableView reloadData];
  });
}

- (void)updateTableInsets {
  if (self.kType == kViewReplacementType) {
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, contentInset, 0);
  } else {
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
  }
}

- (void)updateWithCategory:(NSArray *)category {
  self.category = category;
  HQDispatchToMainQueue(^{
    [self.tableView reloadData];
  });
}

- (void)presentAlertControllerWithMessage:(NSString *)message {
  [self presentAlertControllerWithTitle:@"Внимание" message:message];
}

- (void)endUpdateTableViewWithNewReplacement:(NSArray *)replacement {
  [self _setNewReplasement:replacement];
  HQDispatchToMainQueue(^{
    NSInteger update = self.countCell - [self.replacement count];
    NSIndexSet *section;
    [self.tableView beginUpdates];
    if ([self.replacement count] == 0) {
      section = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, update - 1)];
      [self.tableView deleteSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
      section = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.indexPath.section, update)];
    }

    if ([replacement count] != 0) {
      [self.tableView deleteSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
      [self.tableView reloadData];
    }
    [self.tableView endUpdates];
  });
}

- (void)_setNewReplasement:(NSArray *)replacement {
  self.countCell = [self.replacement count];
  if (replacement) {
    self.replacement = replacement;
  } else {
    self.replacement = [NSArray array];
  }
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
  [self presentAlertControllerWithTitle:title message:message];
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
       forCellReuseIdentifier:kAccessoryCellIdentifire];
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameLabelCell bundle:nil]
       forCellReuseIdentifier:kLabelCellIdentifire];
}

- (void)_settingTableView {
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = estimatedRowHeight;
  self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (self.kType == kViewReplacementType) {
    if ([self.replacement count] != 0) {
      return [self.replacement count] + 1;
    }
    return 2;
  }
  return [self.category count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.kType == kViewReplacementType) {
    return 1;
  }
  BBReplacementCategory *category = [self.category objectAtIndex:section];
  return [category.products count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (section == 0 && self.kType == kViewReplacementType) {
    return heightFirstHeaderSection;
  }
  return heightHeaderSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if (self.kType == kAddReplacementType) {
    BBReplacementCategory *category = [self.category objectAtIndex:section];
    return category.nameCategory;
  }
  return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BBAccessoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
  cell.setRadius = YES;
  cell.accessoryImageView.hidden = YES;

  if (self.kType == kViewReplacementType) {
    if (indexPath.section == 0) {
      BBLabelTableViewCell *labelCell = [self.tableView dequeueReusableCellWithIdentifier:kLabelCellIdentifire];
      labelCell.label.text = infoText;
      return labelCell;
    } else {
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      cell.kSideCornerRadius = kAllCornerRadius;
      if ([self.replacement count] == 0) {
        cell.textLabel.text = @"У Вас нет ни одной замены";
        cell.textLabel.textColor = [BBConstantAndColor applicationGrayColor];
      } else {
        BBReplacementProduct *product = [self.replacement objectAtIndex:indexPath.section - 1];
        cell.textLabel.text = product.nameProduct;
        cell.textLabel.textColor = [UIColor blackColor];
      }
    }
  } else {
    BBReplacementCategory *category = [self.category objectAtIndex:indexPath.section];
    BBReplacementProduct *product = [category.products objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
      cell.kSideCornerRadius = kTopCornerRadius;
    } else if (indexPath.row == ([category.products count] - 1)) {
      cell.kSideCornerRadius = kBottomCornerRadius;
    } else {
      cell.setRadius = NO;
      cell.kSideCornerRadius = kNoneCornerRadius;
    }
    cell.textLabel.text = product.nameProduct;
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (self.kType == kAddReplacementType) {
    BBReplacementCategory *category = [self.category objectAtIndex:indexPath.section];
    BBReplacementProduct *product = [category.products objectAtIndex:indexPath.row];
    [self.output cellDidSelectWithText:product];
  }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.kType == kViewReplacementType) {
    if ([self.replacement count] != 0) {
      return UITableViewCellEditingStyleDelete;
    }
  }
  return UITableViewCellEditingStyleNone;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"Удалить";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    self.indexPath = indexPath;
    BBReplacementProduct *product = [self.replacement objectAtIndex:indexPath.section - 1];
    [self.output deleteElementWithText:product];
  }
}

#pragma mark - Lazy Load

- (UIBarButtonItem *)rightBarButton {
  if (!_rightBarButton) {
    _rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addBarButtonAction)];
    _rightBarButton.tintColor = [BBConstantAndColor applicationGrayColor];
  }
  return _rightBarButton;
}

@end
