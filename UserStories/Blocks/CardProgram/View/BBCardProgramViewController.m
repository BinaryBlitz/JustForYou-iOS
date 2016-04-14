//
//  BBCardProgramViewController.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramViewController.h"

#import "BBCardProgramViewOutput.h"

#import "BBHeaderTableViewCell.h"

@interface BBCardProgramViewController() <UITabBarDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addInBasketButton;

@end

static NSString *kHeaderCellIdentifire = @"headerTableViewCell";

@implementation BBCardProgramViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

    [self _registrateIdentifireCell];
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillLayoutSubviews {
    [self _layoutBasketButton];
}

#pragma mark - Методы BBCardProgramViewInput

- (void)setupInitialState {
    
}

#pragma mark - Actions


- (IBAction)addInBasketButtonAction:(id)sender {
    
}


#pragma mark - TableView

- (void) _registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:kHeaderCellIdentifire];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        BBHeaderTableViewCell *headerCell = [self.tableView dequeueReusableCellWithIdentifier:kHeaderCellIdentifire];
        cell = headerCell;
    }
    
    
    return cell;
}


#pragma mark - Layout Views

- (void)_layoutBasketButton {
    [self.addInBasketButton.layer setMasksToBounds:YES];
    [self.addInBasketButton.layer setCornerRadius:CGRectGetHeight(self.addInBasketButton.frame)/2];
}

@end