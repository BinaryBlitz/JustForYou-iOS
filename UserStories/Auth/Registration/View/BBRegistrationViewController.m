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

typedef enum : NSUInteger {
    kNameTextFiledCell,
    kSubnameTextFiledCell,
    kEmailTextFiledCell
}kTextFiledCell;

@interface BBRegistrationViewController() <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIAlertController *alertController;

@property (weak, nonatomic) BBTextTableViewCell *nameCell;
@property (weak, nonatomic) BBTextTableViewCell *surnameCell;
@property (weak, nonatomic) BBTextTableViewCell *emailCell;

@end

#pragma mark - Constants

static NSInteger numberOfRows = 3;

static CGFloat estimateRowHeight = 44.0f;

@implementation BBRegistrationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self registrateIdentifireCell];
	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions


- (void)_nextButtonAction {
    [self.output nextButtonDidTap];
}

#pragma mark - Методы BBRegistrationViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleRegistrationModule;
    [self createBarButtonItem];
    [self _settingsTableView];
}


- (void)createBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Продолжить"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(_nextButtonAction)];
    item.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (BBUser *)userWithTextFields {
    BBUser *user = [[BBUser alloc] init];
    user.name = [self.nameCell getTextFromTextField];
    user.surname = [self.surnameCell getTextFromTextField];
    user.email = [self.emailCell getTextFromTextField];
    return user;
}

- (void)presentAlertControllerWithMessage:(NSString *)message {
    self.alertController.message = message;
    [self presentViewController:self.alertController animated:YES completion:nil];
}

#pragma mark - Methods TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBTextTableViewCell *textCell = [self.tableView dequeueReusableCellWithIdentifier:kTextFieldCellIdentifire];
    textCell.textField.delegate = self;
    textCell.textField.returnKeyType = UIReturnKeyNext;
    if (indexPath.row == kNameTextFiledCell) {
        self.nameCell = textCell;
        [textCell setPlaceholderInTextField:@"Введите имя"];
    } else if (indexPath.row == kSubnameTextFiledCell) {
        self.surnameCell = textCell;
        [textCell setPlaceholderInTextField:@"Введите фамилию"];
    } else {
        self.emailCell = textCell;
        [textCell setPlaceholderInTextField:@"Введите E-mail"];
        textCell.textField.returnKeyType = UIReturnKeyDone;
    }
    return textCell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameTextCell bundle:nil]
         forCellReuseIdentifier:kTextFieldCellIdentifire];
    
}

- (void)_settingsTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimateRowHeight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_resignFirstResponderWithTap)];
//    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

#pragma mark - TextField Delegate Methods

- (void)_resignFirstResponderWithTap {
    [self.nameCell.textField resignFirstResponder];
    [self.surnameCell.textField resignFirstResponder];
    [self.emailCell.textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.nameCell.textField]) {
        [self.surnameCell.textField becomeFirstResponder];
    } else if ([textField isEqual:self.surnameCell.textField]) {
        [self.emailCell.textField becomeFirstResponder];
    } else if ([textField isEqual:self.emailCell.textField]) {
        [self.emailCell.textField resignFirstResponder];
        [self.output nextButtonDidTap];
    } else {
        [self.nameCell.textField becomeFirstResponder];
    }
    return YES;
}

#pragma mark - Lazy Load

- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"Внимание" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [_alertController addAction:action];
    }
    return _alertController;
}



@end