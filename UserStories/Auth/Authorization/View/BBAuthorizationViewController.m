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



@interface BBAuthorizationViewController() <UITableViewDelegate, UITableViewDataSource, BBInfoRegistrateCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *youView;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) BBKeyStyleTableViewRegist keyStyleTableView;

@property (weak, nonatomic) BBNumberPhoneTableViewCell *numberCell;
@property (weak, nonatomic) BBTextTableViewCell *textCell;

@end

static NSString *kIdentifireNumberCellIdentifire = @"numberPhoneCell";
static NSString *kIdentifireTextFieldCellIdentifire = @"textFieldCell";
static NSString *kInfoRegistCellIdentifire = @"infoRegistTableViewCell";

static NSString *kNibNameNumberPhoneCell = @"BBNumberPhoneTableViewCell";
static NSString *kNibNameTextCell = @"BBTextTableViewCell";
static NSString *kNibNameInfoRegistCell = @"BBInfoRegistTableViewCell";

static NSString *kTextForSendCode = @"Введите код:";

static CGFloat estimateRowHeight = 44.0f;
static CGFloat offsetBottom = 10.0f;

@implementation BBAuthorizationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

    self.keyStyleTableView = kNumberPhoneStyleTableView;
    
    [self.output didTriggerViewReadyEvent];
}

- (void)viewDidLayoutSubviews {
    [self layoutYouView];
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Методы BBAuthorizationViewInput

- (void)setupInitialState {
    [self _registrateIdentifireCell];
    [self _registerNotificationKeyboard];
}


- (void)updateTableViewWithKeyTableView:(BBKeyStyleTableViewRegist)key {
    self.keyStyleTableView = key;
    if (!self.navigationItem.rightBarButtonItem) {
        [self _createBarButtonItem];
    }
    self.informationLabel.text = kTextForSendCode;
    [self.tableView beginUpdates];
    [self.tableView reloadData];
    [self.tableView endUpdates];
}

- (void)getNumberPhoneUser {
    [self.output numberPhoneUserWithString:self.numberCell.numberTextField.text];
}


#pragma mark - Actions

- (void)_nextButtonAction {
    [self.output nextButtonDidPress];
}

- (void)_resignFirstResponderWithTap {
    [self.numberCell.numberTextField resignFirstResponder];
    [self.textCell.textField resignFirstResponder];
}

#pragma mark - Cell Delegate Methods

- (void)sendCodeButtonDidTap {
    [self.numberCell.numberTextField resignFirstResponder];
    [self.output sendCodeButtonDidTap];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.keyStyleTableView == kNumberPhoneStyleTableView) {
        if (indexPath.row == 0) {
            BBNumberPhoneTableViewCell *numberCell = [self.tableView dequeueReusableCellWithIdentifier:kIdentifireNumberCellIdentifire];
            self.numberCell = numberCell;
            cell = numberCell;
        } else {
            BBInfoRegistTableViewCell *infoCell = [[NSBundle mainBundle] loadNibNamed:kNibNameInfoRegistCell
                                                                                owner:self options:nil].lastObject;
            infoCell.delegate = self;
            
            cell = infoCell;
        }
    } else {
        if (indexPath.row == 0) {
            BBTextTableViewCell *textCell = [self.tableView dequeueReusableCellWithIdentifier:kIdentifireTextFieldCellIdentifire];
            textCell.textField.textAlignment = NSTextAlignmentCenter;
            textCell.textField.placeholder = @"код из СМС";
            self.textCell = textCell;
            cell = textCell;
        } else {
            BBInfoRegistTableViewCell *infoCell = [[NSBundle mainBundle] loadNibNamed:kNibNameInfoRegistCell
                                                                                owner:self options:nil].lastObject;
            infoCell.delegate = self;
            infoCell.keyStyleCell = kFinishRegistCellStyle;
            cell = infoCell;
        }
    }
    return cell;
}


- (void)_registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameNumberPhoneCell bundle:nil]
         forCellReuseIdentifier:kIdentifireNumberCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameTextCell bundle:nil]
         forCellReuseIdentifier:kIdentifireTextFieldCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameInfoRegistCell bundle:nil]
         forCellReuseIdentifier:kInfoRegistCellIdentifire];
}

- (void)_settingsTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimateRowHeight;
}

#pragma mark - Notification Methods

-(void) keyboardWillShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGFloat contentOffsetY = -1*(CGRectGetHeight(self.view.frame)-kbSize.height-CGRectGetMaxY(self.tableView.frame)-offsetBottom);
    [self.scrollView setContentOffset:CGPointMake(0, contentOffsetY) animated:YES];
}

-(void) keyboardWillHide:(NSNotification *)notification {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Init Methods 

- (void)_createBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Продолжить"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(_nextButtonAction)];
    item.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - Layout Views

- (void)layoutYouView {
    self.youView.layer.masksToBounds = YES;
    [self.youView.layer setCornerRadius:CGRectGetHeight(self.youView.frame)/2];
}


@end