//
//  BBMyProgramsViewController.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyProgramsViewController.h"

#import "BBMyProgramsViewOutput.h"

#import "BBMyProgramTableViewCell.h"

@interface BBMyProgramsViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *kMyProgramCellIdentifire = @"myProgramTableViewCell";
static NSString *kNibMyProgramCell = @"BBMyProgramTableViewCell";

static CGFloat estimatedHeightCell = 80.0f;
static CGFloat verticalInset = 10.0f;

@implementation BBMyProgramsViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBMyProgramsViewInput

- (void)setupInitialState {
    [self _settingsTableViewAndRegisterNib];
}


#pragma mark - TableView Methods

- (void)_settingsTableViewAndRegisterNib {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedHeightCell;
    self.tableView.contentInset = UIEdgeInsetsMake(verticalInset, 0, verticalInset, 0);
    [self.tableView registerNib:[UINib nibWithNibName:kNibMyProgramCell bundle:nil] forCellReuseIdentifier:kMyProgramCellIdentifire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBMyProgramTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyProgramCellIdentifire];
    cell.keyMode = kProgramCellModeCornerRadius;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectRowWithProgram:2];
}

@end