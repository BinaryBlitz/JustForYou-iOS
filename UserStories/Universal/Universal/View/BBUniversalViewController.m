//
//  BBUniversalViewController.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalViewController.h"

#import "BBUniversalViewOutput.h"
#import "BBCalendarService.h"
#import "BBStock.h"

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
    if (self.keyModule == kMyAddressModule || self.keyModule == kMyAddressForOrderModule) {
        self.navigationItem.rightBarButtonItem = self.addBarButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    self.count = 1;
}

- (void)reloadTableView {
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
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
    HQDispatchToMainQueue(^{
        self.count = [objects count];
        NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.indexPath.section, 1)];
        [self.tableView beginUpdates];
        if ([objects count] != 0) {
            [self.tableView deleteSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self.tableView reloadData];
        }
        [self.tableView endUpdates];
    });
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
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAboutCell bundle:nil]
         forCellReuseIdentifier:kAboutCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.keyModule == kMyAddressModule || self.keyModule == kAboutModule) {
        return miniHeightFooterSection;
    }
    return heightFooterSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.keyModule == kMyAddressModule || self.keyModule == kAboutModule) {
        return miniHeightHeaderSection;
    }
    return heightHeaderSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.keyModule == kSharesModule) {
        id obj;
        if ([self.objects count] > 0) {
            obj = self.objects.firstObject;
        }
        if ([self.objects count] > 0 && (obj && [obj isKindOfClass:[BBStock class]])) {
            BBStock *stock = [self.objects objectAtIndex:section];
            return [[BBCalendarService sharedService] dateForUIWithDate:stock.date];
        }
    }
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.keyModule == kSharesModule || self.keyModule == kMyAddressModule || self.keyModule == kMyAddressForOrderModule) {
        if (self.count != 0) {
            return self.count;
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.keyModule == kSharesModule || self.keyModule == kMyAddressModule ||
        self.keyModule == kMyAddressForOrderModule || self.keyModule == kAboutModule) {
        return 1;
    }
    if (self.count != 0) {
        return self.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
    accessoryCell.setRadius = YES;
    accessoryCell.kSideCornerRadius = kAllCornerRadius;
    accessoryCell.accessoryImageView.hidden = YES;
    accessoryCell.textLabel.textColor = [BBConstantAndColor applicationGrayColor];
    
    id obj;
    if ([self.objects count] > 0) {
        obj = self.objects.firstObject;
    }
    
    if (self.keyModule == kMyProgramModule) {
        BBMyOldProgramTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyOldProgramCellIdentifire];
        return cell;
    } else if (self.keyModule == kMyAddressModule || self.keyModule == kMyAddressForOrderModule) {
        NSString *addressString = @"У вас пока нет ни одного адреса";
        if ([self.objects count] != 0) {
            BBAddress *address = [self.objects objectAtIndex:indexPath.section];
            addressString = address.address;
        }
        accessoryCell.textLabel.text = addressString;
        return accessoryCell;
    } else if (self.keyModule == kSharesModule) {
        if ([self.objects count] == 0 || (obj && ![obj isKindOfClass:[BBStock class]])) {
            accessoryCell.textLabel.text = @"В настоящий момент акций нет";
            return accessoryCell;
        }
        BBStockTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kStockCellIdentifire];
        [cell setStockForUI:[self.objects objectAtIndex:indexPath.section]];
        return cell;
    } else if (self.keyModule == kAboutModule) {
        BBAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kAboutCellIdentifire];
        return cell;
    }  else if (self.keyModule == kMyPayCardModule) {
        if ([self.objects count] == 0) {
            accessoryCell.textLabel.text = @"У вас нет привязанных карт";
            return accessoryCell;
        }
        BBMyCardTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMyPayCardCellIdentifire];
        cell.card = [self.objects objectAtIndex:indexPath.row];
        return cell;
    }
    accessoryCell.textLabel.text = @"Произошла ошибка. Повторите позже";
    return accessoryCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.keyModule == kMyAddressForOrderModule) {
        if ([self.objects count] != 0) {
            [self.output cellDidSelectWithAdress:[self.objects objectAtIndex:indexPath.section]];
        }
    } else if (self.keyModule == kSharesModule) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[BBStockTableViewCell class]]) {
            BBStockTableViewCell *stockCell = (BBStockTableViewCell *)cell;
            [self.output cellDidSelectWithStock:stockCell.stock];
        }
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
