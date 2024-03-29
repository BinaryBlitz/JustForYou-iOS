#import "BBBlocksViewController.h"

#import "BBBlocksViewOutput.h"

#import "BBItemService.h"

@interface BBBlocksViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *blocks;

@end

static CGFloat correlationCoefficientForCell = 1.12f;
static CGFloat sideOffset = 35.0f;

@implementation BBBlocksViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.output viewWillAppear];
  [self.navigationController setNavigationBarHidden:NO];
  [self setNeedsStatusBarAppearanceUpdate];
  [[BBAppAnalitics sharedService] sendControllerWithName:kNameTitleProgramModule];
}

- (BOOL)prefersStatusBarHidden {
  return NO;
}

//#pragma mark - Actions
//
//- (void)_basketButtonAction {
//    
//}
//
#pragma mark - Методы BBBlocksViewInput

- (void)setupInitialState {
  self.navigationItem.title = kNameTitleProgramModule;
  [self.tableView setContentInset:UIEdgeInsetsMake(sideOffset, 0, 0, 0)];
  [self _initRightBarButton];
  [self _registrateIdentifireCell];
}

- (void)blocksForTableView:(NSArray *)blocks {
  self.blocks = blocks;
  HQDispatchToMainQueue(^{
    [self.tableView reloadData];
  });
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
  [self presentAlertControllerWithTitle:title message:message];
}

- (void)updateBasketButtonImageWithImageName:(NSString *)name {
  [[BBItemService sharedService] updateImageInBarButtonItem:self.navigationItem.rightBarButtonItem forImage:name];
//     self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

#pragma mark - TableView

- (void)_registrateIdentifireCell {
  [self.tableView registerNib:[UINib nibWithNibName:kNibNameBlockCell bundle:nil] forCellReuseIdentifier:kBlockCellIdentifire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.blocks) {
    return [self.blocks count];
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return (CGRectGetWidth(self.tableView.frame) / correlationCoefficientForCell);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BBBlockTableViewCell *blockCell = [self.tableView dequeueReusableCellWithIdentifier:kBlockCellIdentifire];

  return blockCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  BBBlockTableViewCell *blockCell = (BBBlockTableViewCell *) cell;
  if ([self.blocks count] > 0) {
    BBBlock *block = [self.blocks objectAtIndex:indexPath.row];
    blockCell.nameBlock.text = block.name;
    blockCell.blockId = block.blockId;
    [blockCell setCountProgram:block.programs_count];
    [[BBImageViewService sharedService] setImageForImageView:blockCell.imageBlock placeholder:[UIImage imageNamed:@"TestIconBlock"] stringURL:block.image];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  BBBlockTableViewCell *blockCell = [tableView cellForRowAtIndexPath:indexPath];
  [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"go_to_types" action:blockCell.nameBlock.text label:@""];
  [self.output didSelectRowWithBlockId:blockCell.blockId];
}

#pragma mark - Init Methods

- (void)_initRightBarButton {
  UIBarButtonItem *item = [[BBItemService sharedService] basketItemWithCallback:^{
    [self.output basketButtonDidTap];
  }];
  self.navigationItem.rightBarButtonItem = item;
}

@end
