//
//  BBSettingsViewController.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsViewController.h"

#import "BBSettingsViewOutput.h"

#import "BBAccessoryTableViewCell.h"
#import "BBSwitchTableViewCell.h"
#import "BBTextTableViewCell.h"

@interface BBSettingsViewController() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

static NSString *kNibNameAccessoryCell = @"BBAccessoryTableViewCell";
static NSString *kNibNameSwitchCell = @"BBSwitchTableViewCell";
static NSString *kNibNameTextCell = @"BBTextTableViewCell";

static NSString *kAccessoryCellIdentifire = @"accessoryTableViewCell";
static NSString *kSwitchCellIdentifire = @"switchTableViewCell";
static NSString *kTextCellIdentifire = @"textFieldCell";

static CGFloat estimatedRowHeight = 44.0f;
static CGFloat heightHeaderSection = 34.0f;
static CGFloat miniHeightHeaderSection = 9.0f;
static CGFloat heightFooterSection = 1.0f;

@implementation BBSettingsViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _layoutLogoutButton];
}

#pragma mark - Actions Methods

- (IBAction)logoutButtonAction:(id)sender {
    
}


#pragma mark - Методы BBSettingsViewInput

- (void)setupInitialState {
	self.navigationItem.title = kNameTitleSettingsModule;
    [self _registerCellIdentifireInTableView];
    [self _settingTableView];
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
         forCellReuseIdentifier:kAccessoryCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameSwitchCell bundle:nil]
         forCellReuseIdentifier:kSwitchCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameTextCell bundle:nil]
         forCellReuseIdentifier:kTextCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return heightFooterSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return heightHeaderSection;
    }
    return miniHeightHeaderSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 2) {
        BBSwitchTableViewCell *switchCell = [self.tableView dequeueReusableCellWithIdentifier:kSwitchCellIdentifire];
        switchCell.customTextLabel.text = @"Push-уведомления";
        switchCell.customTextLabel.textColor = [UIColor blackColor];
        switchCell.setRadius = YES;
        switchCell.kSideCornerRadius = kAllCornerRadius;
        switchCell.kStyleContentCell = kCardContentCell;
        cell = switchCell;
    } else {
        if (indexPath.section == 0) {
            BBTextTableViewCell *textCell = [self.tableView dequeueReusableCellWithIdentifier:kTextCellIdentifire];
            textCell.setRadius = YES;
            textCell.kStyleContentCell = kCardContentCell;
            if (indexPath.row == 0) {
                textCell.textField.text = @"Имя";
                textCell.kSideCornerRadius = kTopCornerRadius;
            } else {
                textCell.textField.text = @"Фамилия";
                textCell.kSideCornerRadius = kBottomCornerRadius;
            }
            cell = textCell;
        } else {
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.setRadius = YES;
            accessoryCell.kSideCornerRadius = kAllCornerRadius;
            if (indexPath.section == 1) {
                accessoryCell.textLabel.text = kNameTitleMyPayCardModule;
                accessoryCell.keyModuleCell = kMyPayCardModule;
            } else {
                accessoryCell.textLabel.text = kNameTitleAboutModule;
                accessoryCell.keyModuleCell = kAboutModule;
            }
            cell = accessoryCell;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 || indexPath.section == 3) {
        BBAccessoryTableViewCell *accessoryCell = [tableView cellForRowAtIndexPath:indexPath];
        [self.output didSelectRowForKeyModule:accessoryCell.keyModuleCell];
    }
}

#pragma mark - Layout Methods

- (void)_layoutLogoutButton {
    self.logoutButton.layer.masksToBounds = YES;
    self.logoutButton.layer.cornerRadius = CGRectGetHeight(self.logoutButton.frame)/2;
}

@end