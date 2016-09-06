//
//  BBAddressViewController.m
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAddressViewController.h"

#import "BBAddressViewOutput.h"

@interface BBAddressViewController() <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) BBAccessoryTableViewCell *streetCell;
@property (strong, nonatomic) BBTextTableViewCell *houseCell;
@property (strong, nonatomic) BBTextTableViewCell *entranceCell;
@property (strong, nonatomic) BBTextTableViewCell *floorCell;
@property (strong, nonatomic) BBTextTableViewCell *apartmentCell;

@property (strong, nonatomic) BBAddress *currentAddress;

@end

static CGFloat estimatedRowHeight = 50.0f;

static CGFloat contentInset = 20.0f;

static CGFloat heightHeaderSection = 10.0f;

@implementation BBAddressViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

- (void)viewDidLayoutSubviews {
    [self _layoutAddButton];
}

#pragma mark - Actions Methods

- (IBAction)addButtonAction:(id)sender {
    [self.output addAddressButtonDidTapWithAddress:self.currentAddress];
}

#pragma mark - Методы BBAddressViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitlNeweAddressModule;
    self.currentAddress = [[BBAddress alloc] init];
    [self _registerCellIdentifireInTableView];
    [self _settingTableView];
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

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

- (void)updateTableViewWithAddress:(BBAddress *)address {
    self.currentAddress = address;
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

- (void)clearFields {
    self.currentAddress = nil;
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

- (void)saveApartmentWithString:(NSString *)apartment {
    self.currentAddress.apartment = [apartment integerValue];
}

#pragma mark - UITableView

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
         forCellReuseIdentifier:kAccessoryCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return heightHeaderSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BBAccessoryTableViewCell *accessoryCell = [[NSBundle mainBundle] loadNibNamed:kNibNameAccessoryCell owner:self options:nil].lastObject;
        accessoryCell.textLabel.textColor = [BBConstantAndColor applicationGrayColor];
        accessoryCell.setRadius = YES;
        accessoryCell.kSideCornerRadius = kAllCornerRadius;
        accessoryCell.accessoryImageView.hidden = NO;
        if (self.currentAddress.street) {
            accessoryCell.textLabel.text = self.currentAddress.street;
        } else {
            accessoryCell.textLabel.text = @"Улица";
        }
        self.streetCell = accessoryCell;
        return accessoryCell;
    } else {
        BBTextTableViewCell *textCell = [[NSBundle mainBundle] loadNibNamed:kNibNameTextCell owner:self options:nil].lastObject;
        textCell.textField.delegate = self;
        textCell.textField.textColor = [BBConstantAndColor applicationGrayColor];
        textCell.setRadius = YES;
        textCell.kStyleContentCell = kCardContentCell;
        textCell.kSideCornerRadius = kAllCornerRadius;
        textCell.textField.returnKeyType = UIReturnKeyDone;
        textCell.textField.text = @"";
        if (indexPath.section == 1) {
            textCell.textField.placeholder = @"Номер дома";
            if (self.currentAddress.house && ![self.currentAddress.house isEqualToString:@""]) {
                textCell.textField.text = self.currentAddress.house;
            }
            self.houseCell = textCell;
        } else if (indexPath.section == 2) {
            textCell.textField.keyboardType = UIKeyboardTypeNumberPad;
            textCell.textField.placeholder = @"Подъезд";
            if (self.currentAddress.entrance != 0) {
                textCell.textField.text = [NSString stringWithFormat:@"%ld", (long)self.currentAddress.entrance];
            }
            self.entranceCell = textCell;
        } else if (indexPath.section == 3) {
            textCell.textField.keyboardType = UIKeyboardTypeNumberPad;
            textCell.textField.placeholder = @"Этаж";
            if (self.currentAddress.floor != 0) {
                textCell.textField.text = [NSString stringWithFormat:@"%ld", (long)self.currentAddress.floor];
            }
            self.floorCell = textCell;
        } else {
            textCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            textCell.textField.placeholder = @"Квартира";
            if (self.currentAddress.apartment != 0) {
                textCell.textField.text = [NSString stringWithFormat:@"%ld", (long)self.currentAddress.apartment];
            }
            self.apartmentCell = textCell;
        }
        return textCell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self.output streetCellDidSelect];
    }
}

#pragma mark - TextField Methods

- (void)_resignFirstResponderWithTap {
    [self.houseCell.textField resignFirstResponder];
    [self.entranceCell.textField resignFirstResponder];
    [self.floorCell.textField resignFirstResponder];
    [self.apartmentCell.textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([textField isEqual:self.houseCell.textField]) {
        self.currentAddress.house = textField.text;
    } else if ([textField isEqual:self.entranceCell.textField]) {
        self.currentAddress.entrance = [[NSString stringWithFormat:@"%@%@", textField.text, string] integerValue];
    } else if ([textField isEqual:self.floorCell.textField]) {
        self.currentAddress.floor = [[NSString stringWithFormat:@"%@%@", textField.text, string] integerValue];
    } else if ([textField isEqual:self.apartmentCell.textField]) {
        if (![self.output apartmentFieldBeginEditingWithSymbol:string textInField:textField.text]) {
            return NO;
        }
    }
    textField.text = [NSString stringWithFormat:@"%@%@", textField.text, string];
    return NO;
}

-(void) keyboardWillShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    self.tableView.contentInset = contentInsets;
}

-(void) keyboardWillHide:(NSNotification *)notification {
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
    [self.tableView setContentOffset:CGPointMake(0, -contentInset) animated:YES];
}

#pragma mark - Layout Methods

- (void)_layoutAddButton {
    [self.addButton.layer setMasksToBounds:YES];
    self.addButton.layer.cornerRadius = CGRectGetHeight(self.addButton.frame)/2;
}


@end