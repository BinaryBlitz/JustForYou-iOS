//
//  BBNewOrderViewController.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderViewController.h"

#import "BBNewOrderViewOutput.h"

#import "BBMyProgramTableViewCell.h"
#import "BBAccessoryTableViewCell.h"

@interface BBNewOrderViewController() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

static NSString *kNibMyProgramCell = @"BBMyProgramTableViewCell";
static NSString *kNibAccessoryCell = @"BBAccessoryTableViewCell";

static NSString *kMyProgramCellIdentifire = @"myProgramTableViewCell";
static NSString *kAccessoryCellIdentifire = @"accessoryTableViewCell";


static CGFloat estimatedHeightCell = 44.0f;

@implementation BBNewOrderViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBNewOrderViewInput

- (void)setupInitialState {
	[self _settingsTableViewAndRegisterNib];
}

#pragma mark - TableView Methods

- (void)_settingsTableViewAndRegisterNib {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedHeightCell;
    [self.tableView registerNib:[UINib nibWithNibName:kNibMyProgramCell bundle:nil] forCellReuseIdentifier:kMyProgramCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibAccessoryCell bundle:nil] forCellReuseIdentifier:kAccessoryCellIdentifire];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        BBMyProgramTableViewCell *myProgramCell = [self.tableView dequeueReusableCellWithIdentifier:kMyProgramCellIdentifire];
        cell = myProgramCell;
    }  else {
        BBMyProgramTableViewCell *myProgramCell = [self.tableView dequeueReusableCellWithIdentifier:kMyProgramCellIdentifire];
        cell = myProgramCell;
    }
    return cell;
}


@end