//
//  BBAuthorizationViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAuthorizationViewController.h"

#import "BBAuthorizationViewOutput.h"

#import "BBUnderlineButton.h"

#import "BBNumberPhoneTableViewCell.h"
#import "BBTextTableViewCell.h"
#import "BBInfoRegistTableViewCell.h"

@interface BBAuthorizationViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *youView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BBNumberPhoneTableViewCell *numberCell;


@end

static NSString *kIdentifireNumberCellIdentifire = @"numberPhoneCell";
static NSString *kIdentifireTextFieldCellIdentifire = @"textFieldCell";
static NSString *kInfoRegistCellIdentifire = @"infoRegistTableViewCell";

static CGFloat heightForRowAtIndexPath = 44.0f;

@implementation BBAuthorizationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

    [self registrateIdentifireCell];
    [self.output didTriggerViewReadyEvent];
}

- (void)viewDidLayoutSubviews {
    [self layoutYouView];
}

#pragma mark - Методы BBAuthorizationViewInput

- (void)setupInitialState {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self createBarButtonItem];
}


- (void)createBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Продолжить"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(_nextButtonAction)];
    item.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)getNumberPhoneUser {
    [self.output numberPhoneUserWithString:self.numberCell.numberTextField.text];
}


#pragma mark - Actions

- (void)_nextButtonAction {
    [self.output nextButtonDidPress];
}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return heightForRowAtIndexPath;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBNumberPhoneTableViewCell *numberCell = [self.tableView dequeueReusableCellWithIdentifier:kIdentifireNumberCellIdentifire];
    self.numberCell = numberCell;
    
    return numberCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void) registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBNumberPhoneTableViewCell" bundle:nil]
         forCellReuseIdentifier:kIdentifireNumberCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:@"BBTextTableViewCell" bundle:nil]
         forCellReuseIdentifier:kIdentifireTextFieldCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:@"BBInfoRegistTableViewCell" bundle:nil]
         forCellReuseIdentifier:kInfoRegistCellIdentifire];
}

#pragma mark - Layout Views

- (void)layoutYouView {
    self.youView.layer.masksToBounds = YES;
    [self.youView.layer setCornerRadius:CGRectGetHeight(self.youView.frame)/2];
}


@end