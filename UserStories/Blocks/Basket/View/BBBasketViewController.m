//
//  BBBasketViewController.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketViewController.h"

#import "BBBasketViewOutput.h"

@interface BBBasketViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end

@implementation BBBasketViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _layoutPayButton];
}

#pragma mark - Actions Methods

- (IBAction)payButtonAction:(id)sender {
    
}

- (IBAction)closeButtonAction:(id)sender {
    [self.output closeButtonDidTap];
}

#pragma mark - Методы BBBasketViewInput

- (void)setupInitialState {
    self.navigationItem.title = @"Корзина";
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}

#pragma mark - Layout Methods

- (void)_layoutPayButton {
    self.payButton.layer.masksToBounds = YES;
    self.payButton.layer.cornerRadius = CGRectGetHeight(self.payButton.frame)/2;
}

@end