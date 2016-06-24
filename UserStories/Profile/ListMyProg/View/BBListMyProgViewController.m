//
//  BBListMyProgViewController.m
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBListMyProgViewController.h"

#import "BBListMyProgViewOutput.h"

@interface BBListMyProgViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *objects;

@end

static CGFloat estimatedRowHeight = 50.0f;

static CGFloat contentInset = 20.0f;

@implementation BBListMyProgViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

#pragma mark - Методы BBListMyProgViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleMyProgramModule;
    [self _settingTableView];
}


- (void)updateTableViewWithArrayObjects:(NSArray *)objects {
    self.objects = objects;
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}


- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

#pragma mark - TableView Methods

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameMyOldProgramCell bundle:nil] forCellReuseIdentifier:kMyOldProgramCellIdentifire];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBMyOldProgramTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyOldProgramCellIdentifire];
    return cell;
}


@end