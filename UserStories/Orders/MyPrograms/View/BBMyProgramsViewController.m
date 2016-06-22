//
//  BBMyProgramsViewController.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyProgramsViewController.h"

#import "BBMyProgramsViewOutput.h"

@interface BBMyProgramsViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *purchases;

@end

static CGFloat estimatedHeightCell = 80.0f;
static CGFloat verticalInset = 10.0f;

@implementation BBMyProgramsViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

#pragma mark - Методы BBMyProgramsViewInput

- (void)setupInitialState {
    [self _settingsTableViewAndRegisterNib];
    self.navigationItem.title = kNameTitleMyProgramModule;
}

- (void)purchasesWithArray:(NSArray *)array {
    self.purchases = array;
}

- (void)reloadTableView {
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

#pragma mark - TableView Methods

- (void)_settingsTableViewAndRegisterNib {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedHeightCell;
    self.tableView.contentInset = UIEdgeInsetsMake(verticalInset, 0, verticalInset, 0);
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameMyProgramCell bundle:nil] forCellReuseIdentifier:kMyProgramCellIdentifire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.purchases count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBMyProgramTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyProgramCellIdentifire];
    cell.keyMode = kProgramCellModeCornerRadius;
    cell.purchases = [self.purchases objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectRowWithPurchase:[self.purchases objectAtIndex:indexPath.row]];
}

@end