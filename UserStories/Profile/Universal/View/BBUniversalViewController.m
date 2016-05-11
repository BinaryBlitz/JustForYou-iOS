//
//  BBUniversalViewController.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalViewController.h"

#import "BBUniversalViewOutput.h"

#import "BBMyOldProgramTableViewCell.h"
#import "BBPaymentHistoryTableViewCell.h"

@interface BBUniversalViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *kMyOldProgramCellIdentifire = @"myOldProgramTableViewCell";
static NSString *kPaymentHistoryCellIdentifire = @"paymentHistoryTableViewCell";

static NSString *kNibMyOldProgramCell = @"BBMyOldProgramTableViewCell";
static NSString *kNibPaymentHistoryCell = @"BBPaymentHistoryTableViewCell";

static CGFloat estimatedRowHeight = 50.0f;
static CGFloat contentOffset = 15.0f;

@implementation BBUniversalViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBUniversalViewInput

- (void)setupInitialState {
    [self _registerCellIdentifireInTableView];
    [self _settingTableView];
}

- (void)navigationTitle:(NSString *)title {
    self.navigationItem.title = title;
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibMyOldProgramCell bundle:nil]
         forCellReuseIdentifier:kMyOldProgramCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibPaymentHistoryCell bundle:nil]
         forCellReuseIdentifier:kPaymentHistoryCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(contentOffset, 0, contentOffset, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        BBMyOldProgramTableViewCell *oldProgramCell = [self.tableView dequeueReusableCellWithIdentifier:kMyOldProgramCellIdentifire];
        cell = oldProgramCell;
    } else {
        BBPaymentHistoryTableViewCell *paymentCell = [self.tableView dequeueReusableCellWithIdentifier:kPaymentHistoryCellIdentifire];
        cell = paymentCell;
    }
    
    return cell;
}

@end