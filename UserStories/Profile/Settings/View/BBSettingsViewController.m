//
//  BBSettingsViewController.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsViewController.h"

#import "BBSettingsViewOutput.h"

@interface BBSettingsViewController() <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@property (strong, nonatomic) BBTextTableViewCell *nameCell;
@property (strong, nonatomic) BBTextTableViewCell *surnameCell;

@property (strong, nonatomic) BBUser *currentUser;

@end

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _layoutLogoutButton];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self _resignFirstResponderWithTap];
    [self.output viewWillDisappear];
}

#pragma mark - Actions Methods

- (IBAction)logoutButtonAction:(id)sender {
    [self.output logoutButtonDidTap];
}


#pragma mark - Методы BBSettingsViewInput

- (void)setupInitialState {
	self.navigationItem.title = kNameTitleSettingsModule;
    [self _registerCellIdentifireInTableView];
    [self _settingTableView];
}

- (void)updateInfoUserWithUser:(BBUser *)user {
    self.currentUser = user;
}

- (BBUser *)currentInfoUser {
    BBUser *user = self.currentUser;
    user.name = self.nameCell.textField.text;
    user.surname = self.surnameCell.textField.text;
    return user;
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
         forCellReuseIdentifier:kAccessoryCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameSwitchCell bundle:nil]
         forCellReuseIdentifier:kSwitchCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameTextCell bundle:nil]
         forCellReuseIdentifier:kTextFieldCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_resignFirstResponderWithTap)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
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
            BBTextTableViewCell *textCell = [self.tableView dequeueReusableCellWithIdentifier:kTextFieldCellIdentifire];
            textCell.textField.delegate = self;
            textCell.setRadius = YES;
            textCell.kStyleContentCell = kCardContentCell;
            if (indexPath.row == 0) {
                textCell.textField.placeholder = @"Имя";
                textCell.kSideCornerRadius = kTopCornerRadius;
                textCell.textField.returnKeyType = UIReturnKeyNext;
                self.nameCell = textCell;
            } else {
                textCell.textField.placeholder = @"Фамилия";
                textCell.kSideCornerRadius = kBottomCornerRadius;
                textCell.textField.returnKeyType = UIReturnKeyDone;
                self.surnameCell = textCell;
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
                accessoryCell.textLabel.text = @"О нас";
                accessoryCell.keyModuleCell = kAboutModule;
            }
            cell = accessoryCell;
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[cell class] isSubclassOfClass:[BBTextTableViewCell class]]) {
        self.nameCell.textField.text = self.currentUser.name;
        self.surnameCell.textField.text = self.currentUser.surname;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 || indexPath.section == 3) {
        BBAccessoryTableViewCell *accessoryCell = [tableView cellForRowAtIndexPath:indexPath];
        [self.output didSelectRowForKeyModule:accessoryCell.keyModuleCell];
    }
}



#pragma mark - TextField Delegate Methods

- (void)_resignFirstResponderWithTap {
    [self.nameCell.textField resignFirstResponder];
    [self.surnameCell.textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.nameCell.textField]) {
        [self.surnameCell.textField becomeFirstResponder];
    } else if ([textField isEqual:self.surnameCell.textField]) {
        [self.surnameCell.textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Layout Methods

- (void)_layoutLogoutButton {
    self.logoutButton.layer.masksToBounds = YES;
    self.logoutButton.layer.cornerRadius = CGRectGetHeight(self.logoutButton.frame)/2;
}

@end