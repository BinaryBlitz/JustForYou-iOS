//
//  BBNewOrderViewController.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderViewController.h"

#import "BBNewOrderViewOutput.h"

@interface BBNewOrderViewController() <UITableViewDataSource, UITableViewDelegate, BBCommentTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *toOrderButton;

@property (strong, nonatomic) BBCommentTableViewCell *commentCell;

@end


static CGFloat estimatedHeightCell = 44.0f;
static CGFloat heightForHeaderSection = 45.0f;
static CGFloat topInsetForTableView = - 35.0f;

@implementation BBNewOrderViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _layoutToOrderButton];
}

#pragma mark - Actions Methods

- (IBAction)toOrderButtonAction:(id)sender {
    
}

- (void)_resignFirstResponderWithTap {
    [self.commentCell.textView resignFirstResponder];
}

#pragma mark - Методы BBNewOrderViewInput

- (void)setupInitialState {
	[self _settingsTableViewAndRegisterNib];
    self.navigationItem.title = kNameTitleNewOrderModule;
    [self _registerNotificationKeyboard];
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
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
}


#pragma mark - TableView Methods

- (void)_settingsTableViewAndRegisterNib {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedHeightCell;
    self.tableView.contentInset = UIEdgeInsetsMake(topInsetForTableView, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameMyProgramCell bundle:nil] forCellReuseIdentifier:kMyProgramCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil] forCellReuseIdentifier:kAccessoryCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameCommentCell bundle:nil] forCellReuseIdentifier:kCommentCellIdentifire];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return heightForHeaderSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    } else if (section == 1) {
        return @"ДОСТАВКА";
    }
    return @"КОММЕНТАРИЙ";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        BBMyProgramTableViewCell *myProgramCell = [self.tableView dequeueReusableCellWithIdentifier:kMyProgramCellIdentifire];
        cell = myProgramCell;
    } else if (indexPath.section == 1) {
        BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
        if (indexPath.row == 0) {
            accessoryCell.textLabel.text = @"Количество дней";
            accessoryCell.countLabel.hidden = NO;
            accessoryCell.setRadius = YES;
            accessoryCell.kSideCornerRadius = kTopCornerRadius;
        } else {
            accessoryCell.textLabel.text = @"Адрес";
            accessoryCell.setRadius = YES;
            accessoryCell.kSideCornerRadius = kBottomCornerRadius;
        }
        cell = accessoryCell;
    } else {
        BBCommentTableViewCell *commentCell = [self.tableView dequeueReusableCellWithIdentifier:kCommentCellIdentifire];
        commentCell.delegate = self;
        cell = commentCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        self.commentCell = (BBCommentTableViewCell *)cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.output countDayCellDidTap];
        } else {
            [self.output adresCellDidTap];
        }
    }
}

#pragma mark - Notification Methods

-(void) keyboardWillShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    
     self.tableView.contentInset = contentInsets;
     self.tableView.scrollIndicatorInsets = contentInsets;
     [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:self.commentCell]
                           atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

-(void) keyboardWillHide:(NSNotification *)notification {
    self.tableView.contentInset = UIEdgeInsetsMake(topInsetForTableView, 0, 0, 0);
    [self.tableView setContentOffset:CGPointMake(0, -topInsetForTableView) animated:YES];
}

#pragma mark - Layout Methods

- (void)_layoutToOrderButton {
    self.toOrderButton.layer.masksToBounds = YES;
    self.toOrderButton.layer.cornerRadius = CGRectGetHeight(self.toOrderButton.frame)/2;
}

@end