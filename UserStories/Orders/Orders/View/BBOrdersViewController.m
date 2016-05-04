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
#import "BBPreviewOrderTableViewCell.h"

@interface BBOrdersViewController() <BBCalendarMenuViewDelegate, UITableViewDelegate, UITableViewDataSource, BBCalendarTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) BBCalendarMenuView *calendarMenu;

@property (strong, nonatomic) BBCalendarTableViewCell *calendarCell;

@property (strong, nonatomic) NSArray *ordersArray;

@end

static NSString *kCalendarCellIdentifire = @"calendarTableViewCell";
static NSString *kNibNameCalendarCell = @"BBCalendarTableViewCell";
static NSString *kNibNamePreviewOrderCell = @"BBPreviewOrderTableViewCell";

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
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameCalendarCell bundle:nil] forCellReuseIdentifier:kCalendarCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.ordersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        BBCalendarTableViewCell *calendarCell = [self.tableView dequeueReusableCellWithIdentifier:kCalendarCellIdentifire];
        self.calendarCell = calendarCell;
        [self _setDelegates];
        cell = calendarCell;
    } else {
        BBPreviewOrderTableViewCell *previewCell = [[NSBundle mainBundle] loadNibNamed:kNibNamePreviewOrderCell owner:self options:nil].lastObject;
        if ([self.ordersArray count] > 0) {
            UIView *dot = [self.ordersArray objectAtIndex:indexPath.row];
            previewCell.indicatorView.backgroundColor = dot.backgroundColor;
        }
        cell = previewCell;
    }
    
    return cell;
}

- (void)_setDelegates {
    self.calendarCell.delegate = self;
    self.delegate = self.calendarCell;
}

#pragma mark - BBCalendarTableViewCellDelegate 

- (void)dayViewDidTapWithOrders:(NSArray *)orders {
    self.ordersArray = orders;
    NSRange range = NSMakeRange(1, 1);
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:range] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - BBCalendarMenuViewDelegate

- (void)leftButtonDidTap {
    [self.delegate leftCalendarMenuButtonDidTap];
}

- (void)rightButtonDidTap {
    [self.delegate rightCalendarMenuButtonDidTap];
}

#pragma mark - Lazy Load

- (BBCalendarMenuView *) calendarMenu {
    if (!_calendarMenu) {
        _calendarMenu = [[BBCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, wightForCalendarMenuView, heightForCalendarMenuView)];
        _calendarMenu.delegate = self;
    }
    return _calendarMenu;
}

- (NSArray *)ordersArray {
    if (!_ordersArray) {
        _ordersArray = [NSArray array];
    }
    return _ordersArray;
}

@end