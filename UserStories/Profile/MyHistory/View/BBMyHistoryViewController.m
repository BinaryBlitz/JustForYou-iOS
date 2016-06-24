//
//  BBMyHistoryViewController.m
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMyHistoryViewController.h"

#import "BBMyHistoryViewOutput.h"

@interface BBMyHistoryViewController()  <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *objects;

@end

static CGFloat estimatedRowHeight = 50.0f;

static CGFloat contentInset = 20.0f;

@implementation BBMyHistoryViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}


#pragma mark - Методы BBMyHistoryViewInput

- (void)setupInitialState {
    [self _settingTableView];
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

- (void)updateTableViewWithArrayObjects:(NSArray *)objects {
    self.objects = objects;
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

#pragma mark - TableView Methods

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNamePaymentHistoryCell bundle:nil]
         forCellReuseIdentifier:kPaymentHistoryCellIdentifire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBPaymentHistoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPaymentHistoryCellIdentifire];
    return cell;
}

@end