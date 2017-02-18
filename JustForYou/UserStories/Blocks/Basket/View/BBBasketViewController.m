#import "BBBasketViewController.h"

#import "BBBasketViewOutput.h"

#import <Realm/Realm.h>
#import "BBOrderProgram.h"
#import "BBTableAlertController.h"

#import "BBUserService.h"

@interface BBBasketViewController() <UITableViewDelegate, UITableViewDataSource, BBBasketCellDelegate, BBTableAlertControllerDelegate, BBSwitchCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *totalLebel;

@property (strong, nonatomic) BBSwitchTableViewCell *switchCell;

@property (strong, nonatomic) NSArray *programOrders;
@property (strong, nonatomic) NSIndexPath *removeIndexPath;
@property (strong, nonatomic) BBOrderProgram *removeOrder;

@property (assign, nonatomic) NSInteger totalPrice;

@end

static CGFloat estimatedHeightCell = 44.0f;
static CGFloat topInsetForTableView = -20.0f;

static CGFloat heightFooter = 13.0f;


@implementation BBBasketViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
    [[BBAppAnalitics sharedService] sendControllerWithName:kNameTitleBasketModule];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _layoutPayButton];
}

#pragma mark - Actions Methods

- (IBAction)payButtonAction:(id)sender {
    [self.output payButtonDidTapWithCount:[self.programOrders count]];
    [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"oplatit" action:@"click" label:@""];
}

- (IBAction)closeButtonAction:(id)sender {
    [self.output closeButtonDidTap];
}

- (void)_presentAlertWithProgram:(BBProgram *)program {
    NSString *message = [NSString stringWithFormat:@"Вы уверены что хотите удалить эту программу из списка покупок: %@", program.name];
    UIAlertController *alert = [self alertControllerWithTitle:@"" message:message titleCancel:@"Отмена"];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Удалить" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.output removeButtonDidTapWithOrderProgram:self.removeOrder];
    }];
    [alert addAction:action];
    HQDispatchToMainQueue(^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

#pragma mark - Методы BBBasketViewInput

- (void)setupInitialState {
    self.totalPrice = 0;
    self.navigationItem.title = kNameTitleBasketModule;
    self.programOrders = [NSArray array];
    [self _settingsTableViewAndRegisterNib];
}

- (void)updateTableViewWithOrders:(NSArray *)orders {
    self.programOrders = orders;
    self.totalPrice = 0;
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

- (void)updateTableViewWithDelete:(NSArray *)objects {
    self.programOrders = objects;
    self.totalPrice = 0;
    HQDispatchToMainQueue(^{
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[self.removeIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        [self.tableView reloadData];
    });
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

- (void)presentNoteAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [self alertControllerWithTitle:title message:message titleCancel:kNextButton];
    HQDispatchToMainQueue(^{
        [self presentViewController:alert animated:YES completion:nil];
        alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
    });
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message titleAction:(NSString *)titleAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *canc = [UIAlertAction actionWithTitle:titleAction style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.output okCancelButtonDidTap];
    }];
    alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
    [alert addAction:canc];
    HQDispatchToMainQueue(^{
        [self presentViewController:alert animated:YES completion:nil];
        alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
    });
}

#pragma mark - TableView Methods

- (void)_settingsTableViewAndRegisterNib {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedHeightCell;
    self.tableView.contentInset = UIEdgeInsetsMake(topInsetForTableView, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameSwitchCell bundle:nil] forCellReuseIdentifier:kSwitchCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameBasketCell bundle:nil] forCellReuseIdentifier:kBasketCellIdentifire];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.programOrders count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return heightFooter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBBasketTableViewCell *basketCell = [self.tableView dequeueReusableCellWithIdentifier:kBasketCellIdentifire];
    BBOrderProgram *orderP = [self.programOrders objectAtIndex:indexPath.row];
    BBProgram *program = [BBProgram objectsWhere:@"programId=%d", orderP.programId].firstObject;
    basketCell.program = program;
    basketCell.orderProgram = orderP;
    basketCell.delegate = self;
    self.totalPrice += [basketCell totalForCountDays];
    [self updateTotalTableViewCell];
    return basketCell;
}

- (void)closeButtonDidTapWithBasketCell:(BBBasketTableViewCell *)cell {
    self.removeIndexPath = [self.tableView indexPathForCell:cell];
    self.removeOrder = cell.orderProgram;
    [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"cart" action:@"delete" label:cell.program.name];
    [self _presentAlertWithProgram:cell.program];
}

- (void)oldTotal:(NSInteger)oldTotal newTotal:(NSInteger)newTotal {
    self.totalPrice = self.totalPrice - oldTotal + newTotal;
    [self updateTotalTableViewCell];
}

- (void)updateTotalTableViewCell {
    NSInteger totalBonuses = 0;
    NSInteger result = self.totalPrice - totalBonuses;
    if (result < 0) {
        result = 0;
    }
    if (result == 0) {
        result = 1;
    }
    HQDispatchToMainQueue(^{
        self.totalLebel.text = [NSString stringWithFormat:@"%ld P", (long)self.totalPrice];
    });
}

- (void)setState:(id)sender {
    [self.output changeStateWithState:[sender isOn]];
}

#pragma mark - TableAlert Methods

- (void)createAndPresentTableAlertWithMessage:(NSString *)message {
    BBTableAlertController *alert = [BBTableAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    alert.delegate = self;
    [self presentViewController:alert animated:YES completion:nil];
    alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
}

- (void)cellDidSelectWithPayCard:(BBPayCard *)card {
    [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"oplata" action:@"connected_card" label:@""];
    [self.output payCardWithCard:card];
}

- (void)payNewCardDidTap {
    [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"oplata" action:@"new_card" label:@""];
    [self.output payNewCardButtonDidTap];
}

- (void)cancelButtonDidTap {
    [[BBAppAnalitics sharedService] sendUIActionWithCategory:@"oplata_otmena" action:@"click" label:@""];
    [self.output cancelButtonDidTap];
}

#pragma mark - Layout Methods

- (void)_layoutPayButton {
    self.payButton.layer.masksToBounds = YES;
    self.payButton.layer.cornerRadius = CGRectGetHeight(self.payButton.frame)/2;
}

@end
