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

@interface BBProfileViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *kAccessoryCellIdentifire = @"accessoryTableViewCell";
static NSInteger numberOfRowsInSecondSection = 5;

@implementation BBProfileViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions

- (void)_settingsBarButtonAction {
    
}

#pragma mark - Методы BBProfileViewInput

- (void)setupInitialState {
    [self _registerCellIdentifireInTableView];
    [self _initRightBarButton];
    self.navigationItem.title = @"Программы";
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBAccessoryTableViewCell" bundle:nil] forCellReuseIdentifier:kAccessoryCellIdentifire];
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
            BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
            accessoryCell.textLabel.text = @"История платежей";
            cell = accessoryCell;
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

#pragma mark - Settings Methods

- (void)_initRightBarButton {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(_settingsBarButtonAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

@end