//
//  BBRegistrationViewController.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationViewController.h"

#import "BBRegistrationViewOutput.h"

#import "BBUnderlineButton.h"

#import "BBTextTableViewCell.h"

typedef enum : NSUInteger {
    kNameTextFiledCell,
    kSubnameTextFiledCell,
    kEmailTextFiledCell
}kTextFiledCell;

@interface BBRegistrationViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) BBTextTableViewCell *nameCell;
@property (weak, nonatomic) BBTextTableViewCell *subnameCell;
@property (weak, nonatomic) BBTextTableViewCell *emailCell;

@end

#pragma mark - Constants

static NSInteger numberOfRows = 3;
static NSString *kIdentifireTextFieldCell = @"textFieldCell";

@implementation BBRegistrationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self registrateIdentifireCell];
	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions


- (void)nextButtonAction {
    [self.output nextButtonDidTap];
}

#pragma mark - Методы BBRegistrationViewInput

- (void)setupInitialState {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self createBarButtonItem];
}


- (void)createBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Продолжить"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(nextButtonAction)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (BBUser *)userWithTextFields {
    BBUser *user = nil;
    user.name = [self.nameCell getTextFromTextField];
    user.subname = [self.subnameCell getTextFromTextField];
    user.email = [self.emailCell getTextFromTextField];
    return user;
}


#pragma mark - Methods TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBTextTableViewCell *textCell = [self.tableView dequeueReusableCellWithIdentifier:kIdentifireTextFieldCell];
    if (indexPath.row == kNameTextFiledCell) {
        self.nameCell = textCell;
        [textCell setPlaceholderInTextField:@"Введите имя"];
    } else if (indexPath.row == kSubnameTextFiledCell) {
        self.subnameCell = textCell;
        [textCell setPlaceholderInTextField:@"Введите фамилию"];
    } else {
        self.emailCell = textCell;
        [textCell setPlaceholderInTextField:@"Введите E-mail"];
    }
    return textCell;
}


- (void) registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBTextTableViewCell" bundle:nil] forCellReuseIdentifier:kIdentifireTextFieldCell];
    
}



@end