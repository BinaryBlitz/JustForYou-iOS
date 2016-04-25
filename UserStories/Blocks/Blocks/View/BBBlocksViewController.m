//
//  BBBlocksViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksViewController.h"

#import "BBBlocksViewOutput.h"

#import "BBBlockTableViewCell.h"

@interface BBBlocksViewController() <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *kIdentifireBlockCell = @"blockCell";

static CGFloat correlationCoefficientForCell = 1.12f;

@implementation BBBlocksViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self _registrateIdentifireCell];
	[self.output didTriggerViewReadyEvent];
}


#pragma mark - Actions

- (void)basketButtonAction {
    
}

#pragma mark - Методы BBBlocksViewInput

- (void)setupInitialState {
    self.navigationItem.title = @"Программы";
    [self.tableView setContentInset:UIEdgeInsetsMake(bottomOffsetForBlockTableView, 0, 0, 0)];
    [self _initRightBarButton];
}

#pragma mark - TableView

- (void) _registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBBlockTableViewCell" bundle:nil] forCellReuseIdentifier:kIdentifireBlockCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (CGRectGetWidth(self.tableView.frame) / correlationCoefficientForCell);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBBlockTableViewCell *blockCell = [self.tableView dequeueReusableCellWithIdentifier:kIdentifireBlockCell];
    
    return blockCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.output didSelectRow];
}

#pragma mark - Init Methods

- (void)_initRightBarButton {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"basket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(basketButtonAction)];
    
    self.navigationItem.rightBarButtonItem = item;
}

@end