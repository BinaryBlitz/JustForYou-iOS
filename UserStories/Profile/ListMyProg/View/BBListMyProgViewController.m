//
//  BBListMyProgViewController.m
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBListMyProgViewController.h"

#import "BBListMyProgViewOutput.h"

#import "BBAddBasketViewPopover.h"

@interface BBListMyProgViewController() <UITableViewDelegate, UITableViewDataSource, BBAddBasketViewDelegate, BBMyOldProgramCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) BBAddBasketViewPopover *addBasketPopover;

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

- (void)changeImageAndPresentAlertControllerWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle {
    [self.addBasketPopover removeFromSuperview];
    
    [self presentAlertControllerWithTitle:@"" message:message titleCancel:cancelTitle];
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
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBMyOldProgramTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyOldProgramCellIdentifire];
    cell.purchase = [self.objects objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - Delegate Methods

- (void)extendButtonDidTap {
    [self _showAddInBasketPopover];
}

- (void)_showAddInBasketPopover {
    [self.view addSubview:self.addBasketPopover];
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count {
//    [self.output okButtonDidTapWithCountDays:count];
}

#pragma mark - Lazy Load

- (BBAddBasketViewPopover *)addBasketPopover {
    if (!_addBasketPopover) {
        _addBasketPopover = [[BBAddBasketViewPopover alloc] initWithFrame:self.view.bounds];
        _addBasketPopover.delegate = self;
    }
    return _addBasketPopover;
}

@end