//
//  BBReplaceProgramViewController.m
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramViewController.h"

#import "BBReplaceProgramViewOutput.h"

@interface BBReplaceProgramViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static CGFloat estimatedHeightCell = 80.0f;
static CGFloat verticalInset = 10.0f;

@implementation BBReplaceProgramViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBReplaceProgramViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleReplaceProgramModule;
    [self _settingTableView];
}

#pragma mark - TableView Methods

- (void)_settingTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedHeightCell;
    self.tableView.contentInset = UIEdgeInsetsMake(verticalInset, 0, verticalInset, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBMyProgramTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:kNibNameMyProgramCell owner:self options:nil].lastObject;
    
    return cell;
}

@end