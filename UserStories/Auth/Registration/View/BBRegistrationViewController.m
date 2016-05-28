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


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *youView;

@property (weak, nonatomic) BBTextTableViewCell *nameCell;
@property (weak, nonatomic) BBTextTableViewCell *surnameCell;
@property (weak, nonatomic) BBTextTableViewCell *emailCell;

@end

#pragma mark - Constants

static NSInteger numberOfRows = 3;

static CGFloat estimateRowHeight = 44.0f;
static CGFloat offsetBottom = 10.0f;

@implementation BBRegistrationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self registrateIdentifireCell];
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutYouView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Actions


- (void)_nextButtonAction {
    [self.output nextButtonDidTap];
}

#pragma mark - Методы BBRegistrationViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleRegistrationModule;
    self.navigationItem.hidesBackButton = YES;
    [self _createBarButtonItem];
    [self _registerNotificationKeyboard];
    [self _settingsTableView];
}


- (void)_registerNotificationKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_resignFirstResponderWithTap)];
    [self.scrollView addGestureRecognizer:tap];
}

- (void)_createBarButtonItem {
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
    [self presentAlertControllerWithTitle:@"Внимание" message:message withCancelActionTitle:@"Ok"];
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
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_resignFirstResponderWithTap)];
////    tap.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:tap];
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

-(void) keyboardWillShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGFloat contentOffsetY = -1*(CGRectGetHeight(self.view.frame)-kbSize.height-CGRectGetMaxY(self.tableView.frame) - offsetBottom);
    [self.scrollView setContentOffset:CGPointMake(0, contentOffsetY) animated:YES];
}

-(void) keyboardWillHide:(NSNotification *)notification {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Layout Methods

- (void)layoutYouView {
    self.youView.layer.masksToBounds = YES;
    [self.youView.layer setCornerRadius:CGRectGetHeight(self.youView.frame)/2];
}

@end