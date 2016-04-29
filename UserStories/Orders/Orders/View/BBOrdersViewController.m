//
//  BBOrdersViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersViewController.h"

#import "BBOrdersViewOutput.h"

#import "BBCalendarMenuView.h"
#import "BBDottedBorderButton.h"

#import "BBCalendarTableViewCell.h"

@interface BBOrdersViewController() <BBCalendarMenuViewDelegate, UITableViewDelegate, UITableViewDataSource, BBCalendarTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) BBCalendarMenuView *calendarMenu;

@property (strong, nonatomic) BBCalendarTableViewCell *calendarCell;

@end

static NSString *kCalendarCellIdentifire = @"calendarTableViewCell";

static CGFloat wightForCalendarMenuView = 140.0f;
static CGFloat heightForCalendarMenuView = 32.0f;
static CGFloat estimatedRowHeight = 100.0f;

@implementation BBOrdersViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBOrdersViewInput

- (void)setupInitialState {
    [self _registerNibWithIdentifireCell];
    [self _settingTableView];
    self.navigationItem.titleView = self.calendarMenu;
}

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
    self.calendarMenu.titleLabel.text = currentName;
}

#pragma mark - TableView Methods

- (void)_registerNibWithIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBCalendarTableViewCell" bundle:nil] forCellReuseIdentifier:kCalendarCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBCalendarTableViewCell *calendarCell = [self.tableView dequeueReusableCellWithIdentifier:kCalendarCellIdentifire];
    self.calendarCell = calendarCell;
    
    return calendarCell;
}

- (void)_setDelegates {
    self.calendarCell.delegate = self;
    self.delegate = self.calendarCell;
}

#pragma mark - BBCalendarMenuViewDelegate

- (void)leftButtonDidTap {
    [self.delegate leftCalendarMenuButtonDidTap];
}

- (void)rightButtonDidTap {
    [self.delegate leftCalendarMenuButtonDidTap];
}

#pragma mark - Lazy Load

- (BBCalendarMenuView *) calendarMenu {
    if (!_calendarMenu) {
        _calendarMenu = [[BBCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, wightForCalendarMenuView, heightForCalendarMenuView)];
        _calendarMenu.delegate = self;
    }
    return _calendarMenu;
}

@end