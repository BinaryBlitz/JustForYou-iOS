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

@interface BBUniversalViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) BBKeyModuleForUniversalModule keyModule;

@end

static NSString *kMyOldProgramCellIdentifire = @"myOldProgramTableViewCell";
static NSString *kPaymentHistoryCellIdentifire = @"paymentHistoryTableViewCell";
static NSString *kMyPayCardCellIdentifire = @"myCardTableViewCell";

static NSString *kNibMyOldProgramCell = @"BBMyOldProgramTableViewCell";
static NSString *kNibPaymentHistoryCell = @"BBPaymentHistoryTableViewCell";
static NSString *kNibMyPayCardCell = @"BBMyCardTableViewCell";

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
    if (self.keyModule == kMyProgramModule) {
        BBMyOldProgramTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyOldProgramCellIdentifire];
        return cell;
    } else if (self.keyModule == kMyHystoryPaymentModule) {
        BBPaymentHistoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPaymentHistoryCellIdentifire];
        return cell;
    } else {
        BBMyCardTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyPayCardCellIdentifire];
        return cell;
    }
}

@end