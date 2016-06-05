//
//  BBProfileViewController.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfileViewController.h"

#import "BBProfileViewOutput.h"

@interface BBProfileViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSInteger numberOfRowsInSecondSection = 5;

@implementation BBProfileViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Actions

- (void)_settingsBarButtonAction {
    [self.output settingsButtonDidTap];
}

#pragma mark - Методы BBProfileViewInput

- (void)setupInitialState {
    [self _registerCellIdentifireInTableView];
    [self _initRightBarButton];
    [self _setHeightCell];
    self.navigationItem.title = kNameTitleProfileModule;
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
         forCellReuseIdentifier:kAccessoryCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameProfileCell bundle:nil]
         forCellReuseIdentifier:kProfileCellIdentifire];
}

- (void)_setHeightCell {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return numberOfRowsInSecondSection;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BBProfileTableViewCell *profileCell = [self.tableView dequeueReusableCellWithIdentifier:kProfileCellIdentifire];
            
            cell = profileCell;
        }
        if (indexPath.row == 1) {
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.textLabel.text = kNameTitleProgramModule;
            accessoryCell.keyModuleCell = kMyProgramModule;
            accessoryCell.setRadius = YES;
            accessoryCell.kSideCornerRadius = kTopCornerRadius;
            cell = accessoryCell;
        }
        if (indexPath.row == 2) {
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.textLabel.text = kNameTitleAddressModule;
            accessoryCell.keyModuleCell = kMyAddressModule;
            cell = accessoryCell;
        }
        if (indexPath.row == 3) {
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.textLabel.text =kNameTitleHystoryPaymentsModule;
            accessoryCell.keyModuleCell = kMyHystoryPaymentModule;
            cell = accessoryCell;
        }
        if (indexPath.row == 4) {
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.textLabel.text = kNameTitleReplacementModule;
            accessoryCell.keyModuleCell = kReplacementModule;
            accessoryCell.setRadius = YES;
            accessoryCell.kSideCornerRadius = kBottomCornerRadius;
            cell = accessoryCell;
        }
    } else {
        BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
        accessoryCell.textLabel.text = kNameTitleSharesModule;
        accessoryCell.keyModuleCell = kSharesModule;
        accessoryCell.setRadius = YES;
        accessoryCell.kSideCornerRadius = kAllCornerRadius;
        cell = accessoryCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.section == 0 && indexPath.row != 0) || indexPath.section != 0) {
        BBAccessoryTableViewCell *accessoryCell = [tableView cellForRowAtIndexPath:indexPath];
        [self.output didSelectRowForKeyModule:accessoryCell.keyModuleCell];
    }
}

#pragma mark - Settings Methods

- (void)_initRightBarButton {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(_settingsBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

@end