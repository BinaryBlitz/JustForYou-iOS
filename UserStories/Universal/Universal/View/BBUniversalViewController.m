//
//  BBUniversalViewController.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalViewController.h"

#import "BBUniversalViewOutput.h"

@interface BBUniversalViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIBarButtonItem *addBarButton;

@property (strong, nonatomic) NSArray *objects;
@property (nonatomic) NSInteger count;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (nonatomic) BBKeyModuleForUniversalModule keyModule;

@end


static CGFloat estimatedRowHeight = 50.0f;

static CGFloat contentInset = 20.0f;

static CGFloat miniHeightHeaderSection = 5.0f;
static CGFloat miniHeightFooterSection = 5.0f;

static CGFloat heightHeaderSection = 10.0f;
static CGFloat heightFooterSection = 10.0f;

@implementation BBUniversalViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

#pragma mark - Методы BBUniversalViewInput

- (void)setupInitialState {
    [self _registerCellIdentifireInTableView];
    [self _settingTableView];
}

- (void)navigationTitle:(NSString *)title keyModule:(BBKeyModuleForUniversalModule)key {
    self.navigationItem.title = title;
    self.keyModule = key;
}

- (void)settingView {
    if (self.keyModule == kMyAddressModule) {
        self.navigationItem.rightBarButtonItem = self.addBarButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.count = 3;
}

- (void)updateTableViewWithArrayObjects:(NSArray *)objects {
    self.objects = objects;
    self.count = [objects count];
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

- (void)updateTableViewWithDeletedObjects:(NSArray *)objects {
    self.objects = objects;
    self.count = [objects count];
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.indexPath.section, 1)];
    [self.tableView beginUpdates];
    [self.tableView deleteSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}


- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}


#pragma mark - Actions Methods

- (void)_addBarButtonAction {
    [self.output addBarButtonDidTap];
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameMyOldProgramCell bundle:nil]
         forCellReuseIdentifier:kMyOldProgramCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNamePaymentHistoryCell bundle:nil]
         forCellReuseIdentifier:kPaymentHistoryCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameMyPayCardCell bundle:nil]
         forCellReuseIdentifier:kMyPayCardCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameStockCell bundle:nil]
         forCellReuseIdentifier:kStockCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
         forCellReuseIdentifier:kAccessoryCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.keyModule == kMyAddressModule) {
        return miniHeightFooterSection;
    }
    return heightFooterSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.keyModule == kMyAddressModule) {
        return miniHeightHeaderSection;
    }
    return heightHeaderSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.keyModule == kSharesModule) {
        return @"20.10.2016";
    }
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.keyModule == kSharesModule || self.keyModule == kMyAddressModule || self.keyModule == kMyAddressForOrderModule) {
        return self.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.keyModule == kSharesModule || self.keyModule == kMyAddressModule || self.keyModule == kMyAddressForOrderModule) {
        return 1;
    }
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.keyModule == kMyProgramModule) {
        BBMyOldProgramTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyOldProgramCellIdentifire];
        return cell;
    } else if (self.keyModule == kMyHystoryPaymentModule) {
        BBPaymentHistoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kPaymentHistoryCellIdentifire];
        return cell;
    } else if (self.keyModule == kMyAddressModule || self.keyModule == kMyAddressForOrderModule) {
        BBAccessoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
        cell.setRadius = YES;
        cell.kSideCornerRadius = kAllCornerRadius;
        cell.accessoryImageView.hidden = YES;
        BBAddress *address = [self.objects objectAtIndex:indexPath.section];
        cell.textLabel.text = address.address;
        return cell;
    } else if (self.keyModule == kSharesModule) {
        BBStockTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kStockCellIdentifire];
        return cell;
    }  else {
        BBMyCardTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyPayCardCellIdentifire];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.keyModule == kMyAddressForOrderModule) {
        BBAccessoryTableViewCell *adressCell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self.output cellDidSelectWithAdress:adressCell.textLabel.text];
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.keyModule == kMyAddressModule) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Удалить";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.indexPath = indexPath;
        [self.output deletedCellWithAddress:[self.objects objectAtIndex:indexPath.section]];
    }
}

#pragma mark - Lazy Load

- (UIBarButtonItem *)addBarButton {
    if (!_addBarButton) {
        _addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addBarButtonAction)];
        _addBarButton.tintColor = [BBConstantAndColor applicationGrayColor];
    }
    return _addBarButton;
}


@end
