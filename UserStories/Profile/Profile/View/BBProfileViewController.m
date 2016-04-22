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

@implementation BBProfileViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBProfileViewInput

- (void)setupInitialState {
    [self _registerCellIdentifireInTableView];
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBAccessoryTableViewCell" bundle:nil] forCellReuseIdentifier:kAccessoryCellIdentifire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
    cell = accessoryCell;
    return cell;
}

@end