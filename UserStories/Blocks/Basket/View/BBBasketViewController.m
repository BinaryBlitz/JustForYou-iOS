//
//  BBBasketViewController.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketViewController.h"

#import "BBBasketViewOutput.h"

#import "BBSwitchTableViewCell.h"
#import "BBBasketTableViewCell.h"

@interface BBBasketViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end

static NSString *kNibSwitchCell = @"BBSwitchTableViewCell";
static NSString *kNibBasketCell = @"BBBasketTableViewCell";

static NSString *kSwitchCellIdentifire = @"switchTableViewCell";
static NSString *kBasketCellIdentifire = @"basketTableViewCell";

static CGFloat estimatedHeightCell = 44.0f;
static CGFloat topInsetForTableView = -35.0f;

@implementation BBBasketViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _layoutPayButton];
}

#pragma mark - Actions Methods

- (IBAction)payButtonAction:(id)sender {
    
}

- (IBAction)closeButtonAction:(id)sender {
    [self.output closeButtonDidTap];
}

#pragma mark - Методы BBBasketViewInput

- (void)setupInitialState {
    self.navigationItem.title = @"Корзина";
    [self _settingsTableViewAndRegisterNib];
}

#pragma mark - TableView Methods

- (void)_settingsTableViewAndRegisterNib {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedHeightCell;
    self.tableView.contentInset = UIEdgeInsetsMake(topInsetForTableView, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:kNibSwitchCell bundle:nil] forCellReuseIdentifier:kSwitchCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibBasketCell bundle:nil] forCellReuseIdentifier:kBasketCellIdentifire];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        BBSwitchTableViewCell *switchCell = [self.tableView dequeueReusableCellWithIdentifier:kSwitchCellIdentifire];
        switchCell.customTextLabel.text = @"Использовать бонусы";
        cell = switchCell;
    } else {
        BBBasketTableViewCell *basketCell = [self.tableView dequeueReusableCellWithIdentifier:kBasketCellIdentifire];
        
        cell = basketCell;
    }
    return cell;
}

#pragma mark - Layout Methods

- (void)_layoutPayButton {
    self.payButton.layer.masksToBounds = YES;
    self.payButton.layer.cornerRadius = CGRectGetHeight(self.payButton.frame)/2;
}

@end