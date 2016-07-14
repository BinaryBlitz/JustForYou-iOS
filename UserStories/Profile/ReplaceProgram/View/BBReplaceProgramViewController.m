//
//  BBReplaceProgramViewController.m
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramViewController.h"

#import "BBReplaceProgramViewOutput.h"

#import "BBTableAlertController.h"

@interface BBReplaceProgramViewController() <UITableViewDelegate, UITableViewDataSource, BBTableAlertControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *programs;
@property (strong, nonatomic) BBPurchases *purchase;

@end

static CGFloat estimatedHeightCell = 80.0f;
static CGFloat verticalInset = 10.0f;

@implementation BBReplaceProgramViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

#pragma mark - Методы BBReplaceProgramViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleReplaceProgramModule;
    [self _settingTableView];
}

- (void)updateTableViewWithArray:(NSArray *)programs {
    self.programs = programs;
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

- (void)setPurchaseForReplace:(BBPurchases *)purchase {
    self.purchase = purchase;
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

//- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message titleAction:(NSString *)titleAction {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *canc = [UIAlertAction actionWithTitle:titleAction style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self.output okCancelButtonDidTap];
//    }];
//    alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
//    [alert addAction:canc];
//    HQDispatchToMainQueue(^{
//        [self presentViewController:alert animated:YES completion:nil];
//        alert.view.tintColor = [BBConstantAndColor applicationOrangeColor];
//    });
//}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message
                            titleAction:(NSString *)titleAction cancelTitle:(NSString *)cancel key:(BBKeyForOkButtonAlert)key {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:titleAction style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.output okCancelButtonDidTapWithKey:key];
    }];
    if (cancel) {
        UIAlertAction *canc = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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

#pragma mark - TableView Methods

- (void)_settingTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedHeightCell;
    self.tableView.contentInset = UIEdgeInsetsMake(verticalInset, 0, verticalInset, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.programs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBMyProgramTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:kNibNameMyProgramCell owner:self options:nil].lastObject;
    cell.keyMode = kProgramCellModeCornerRadius;
    BBProgram *program = [self.programs objectAtIndex:indexPath.row];
    cell.nameLabel.text = program.name;
    BBBlock *block = [BBBlock objectsWhere:[NSString stringWithFormat:@"blockId=%ld", (long)program.parentId]].lastObject;
    cell.indicatorView.backgroundColor = [BBConstantAndColor colorForR:block.red G:block.green B:block.blue alpha:1.0f];
    cell.subNameLabel.text = block.name;
    cell.countDayLabel.textColor = [BBConstantAndColor applicationOrangeColor];
    cell.countDayLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [self setTotalCostForLabel:cell.countDayLabel program:program];
    return cell;
}

- (void)setTotalCostForLabel:(UILabel *)label program:(BBProgram *)program {
    if (self.purchase.countDays >= program.threshold) {
        label.text = [NSString stringWithFormat:@"%ld P", (long)program.secondaryPrice];
    } else {
        label.text = [NSString stringWithFormat:@"%ld P", (long)program.primaryPrice];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output cellDidSelectRowWithProgram:[self.programs objectAtIndex:indexPath.row]];
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

@end