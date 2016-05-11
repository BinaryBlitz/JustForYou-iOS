//
//  BBProfileViewController.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfileViewController.h"

#import "BBProfileViewOutput.h"

#import "BBAccessoryTableViewCell.h"
#import "BBProfileTableViewCell.h"

@interface BBProfileViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *kAccessoryCellIdentifire = @"accessoryTableViewCell";
static NSString *kProfileCellIdentifire = @"profileTableViewCell";
static NSInteger numberOfRowsInSecondSection = 5;

@implementation BBProfileViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
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
    self.navigationItem.title = @"Профиль";
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBAccessoryTableViewCell" bundle:nil]
         forCellReuseIdentifier:kAccessoryCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:@"BBProfileTableViewCell" bundle:nil]
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
            accessoryCell.textLabel.text = @"Программы";
            accessoryCell.setRadius = YES;
            accessoryCell.kSideCornerRadius = kTopCornerRadius;
            cell = accessoryCell;
        }
        if (indexPath.row == 2) {
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.textLabel.text = @"Адреса";
            cell = accessoryCell;
        }
        if (indexPath.row == 3) {
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.textLabel.text = @"История платежей";
            cell = accessoryCell;
        }
        if (indexPath.row == 4) {
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.textLabel.text = @"Замены";
            accessoryCell.setRadius = YES;
            accessoryCell.kSideCornerRadius = kBottomCornerRadius;
            cell = accessoryCell;
        }
    } else {
        BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
        accessoryCell.textLabel.text = @"Акции";
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
        if ([accessoryCell.textLabel.text isEqualToString:@"Программы"]) {
            [self.output didSelectRowForTitle:@"Мои программы"];
        } else {
            [self.output didSelectRowForTitle:accessoryCell.textLabel.text];
        }
    }
}

#pragma mark - Settings Methods

- (void)_initRightBarButton {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(_settingsBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

@end