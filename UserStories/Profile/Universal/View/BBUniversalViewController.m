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
#import "BBMyCardTableViewCell.h"
#import "BBStockTableViewCell.h"


@interface BBUniversalViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) BBKeyModuleForUniversalModule keyModule;

@end

static NSString *kMyOldProgramCellIdentifire = @"myOldProgramTableViewCell";
static NSString *kPaymentHistoryCellIdentifire = @"paymentHistoryTableViewCell";
static NSString *kMyPayCardCellIdentifire = @"myCardTableViewCell";
static NSString *kStockCellIdentifire = @"stockTableViewCell";


static NSString *kNibMyOldProgramCell = @"BBMyOldProgramTableViewCell";
static NSString *kNibPaymentHistoryCell = @"BBPaymentHistoryTableViewCell";
static NSString *kNibMyPayCardCell = @"BBMyCardTableViewCell";
static NSString *kNibStockCell = @"BBStockTableViewCell";


static CGFloat estimatedRowHeight = 50.0f;

static CGFloat contentInset = 20.0f;
static CGFloat heightHeaderSection = 10.0f;
static CGFloat heightFooterSection = 10.0f;

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

- (void)navigationTitle:(NSString *)title keyModule:(BBKeyModuleForUniversalModule)key {
    self.navigationItem.title = title;
    self.keyModule = key;
    [self.tableView reloadData];
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibMyOldProgramCell bundle:nil]
         forCellReuseIdentifier:kMyOldProgramCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibPaymentHistoryCell bundle:nil]
         forCellReuseIdentifier:kPaymentHistoryCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibMyPayCardCell bundle:nil]
         forCellReuseIdentifier:kMyPayCardCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibStockCell bundle:nil]
         forCellReuseIdentifier:kStockCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return heightFooterSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return heightHeaderSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.keyModule == kSharesModule) {
        return @"20.10.2016";
    }
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.keyModule == kSharesModule) {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.keyModule == kSharesModule) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.keyModule == kMyProgramModule) {
        BBMyOldProgramTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyOldProgramCellIdentifire];
        return cell;
    } else if (self.keyModule == kMyHystoryPaymentModule) {
        BBPaymentHistoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPaymentHistoryCellIdentifire];
        return cell;
    } else if (self.keyModule == kMyAddressModule) {
        BBStockTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kStockCellIdentifire];
        return cell;
    } else if (self.keyModule == kSharesModule) {
        BBStockTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kStockCellIdentifire];
        return cell;
    } else {
        BBMyCardTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyPayCardCellIdentifire];
        return cell;
    }
}

@end