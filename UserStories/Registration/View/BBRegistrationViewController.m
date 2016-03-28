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

#import "BBNumberPhoneTableViewCell.h"

@interface BBRegistrationViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *youView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *smsLabel;
@property (weak, nonatomic) IBOutlet BBUnderlineButton *sendAgainButton;

@end


static NSString *kIdentifireNumberCell = @"numberPhoneCell";


@implementation BBRegistrationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self registrateIdentifireCell];
	[self.output didTriggerViewReadyEvent];
}

- (void)viewDidLayoutSubviews {
    [self layoutYouView];
}

#pragma mark - Методы BBRegistrationViewInput

- (void)setupInitialState {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (IBAction)sendAgainActionButton:(id)sender {
    
}

- (IBAction)nextButtonAction:(id)sender {
    
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBNumberPhoneTableViewCell *numberCell = [self.tableView dequeueReusableCellWithIdentifier:kIdentifireNumberCell];
    
    return numberCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void) registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBNumberPhoneTableViewCell" bundle:nil] forCellReuseIdentifier:kIdentifireNumberCell];
    
}

#pragma mark - Layout Views

- (void)layoutYouView {
    self.youView.layer.masksToBounds = YES;
    [self.youView.layer setCornerRadius:CGRectGetHeight(self.youView.frame)/2];
}

@end