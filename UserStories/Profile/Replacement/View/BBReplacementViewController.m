//
//  BBReplacementViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplacementViewController.h"

#import "BBReplacementViewOutput.h"

@interface BBReplacementViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIBarButtonItem *rightBarButton;

@property (assign, nonatomic) BBTypeReplacementController kType;

@property (strong, nonatomic) NSArray *replacement;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (nonatomic) NSUInteger countCell;

@end

static CGFloat estimatedRowHeight = 50.0f;

static CGFloat contentInset = 20.0f;

static CGFloat heightHeaderSection = 10.0f;
//static CGFloat heightFooterSection = 10.0f;


@implementation BBReplacementViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.countCell = 3;
    
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.output viewWillAppear];
}

#pragma mark - Actions Methods

- (void)_addBarButtonAction {
    [self.output addBarButtonDidTap];
}

#pragma mark - Методы BBReplacementViewInput

- (void)typeForController:(BBTypeReplacementController)type {
    self.kType = type;
}

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleReplacementModule;
    if (self.kType == kViewReplacementType) {
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }
    [self _registerCellIdentifireInTableView];
    [self _settingTableView];
}

- (NSInteger)countReplacementInTableView {
    return [self.replacement count];
}

- (void)currentReplacementArray:(NSArray *)replacement {
    [self _setNewReplasement:replacement];
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

- (void)presentAlertControllerWithMessage:(NSString *)message {
    [self presentAlertControllerWithTitle:@"Внимание" message:message];
}

- (void)endUpdateTableViewWithNewReplacement:(NSArray *)replacement {
    [self _setNewReplasement:replacement];
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.indexPath.section, 1)];
    [self.tableView beginUpdates];
    [self.tableView deleteSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (void)_setNewReplasement:(NSArray *)replacement {
    if (replacement) {
        self.replacement = replacement;
    } else {
        self.replacement = [NSArray array];
    }
}

#pragma mark - TableView Methods

- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
         forCellReuseIdentifier:kAccessoryCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(contentInset, 0, contentInset, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.kType == kViewReplacementType) {
        if ([self.replacement count] != 0) {
            return [self.replacement count];
        }
        return 1;
    }
    return self.countCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.kType == kViewReplacementType) {
        return 1;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.kType == kViewReplacementType) {
        if ([self.replacement count] == 0) {
            return 0;
        }
    }
    return heightHeaderSection;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.kType == kAddReplacementType) {
        return @"Молочные продукты";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBAccessoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
    cell.accessoryImageView.hidden = YES;
    if (self.kType == kViewReplacementType) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self.replacement count] == 0) {
            cell.textLabel.text = @"У Вас нет ни одной замены";
            cell.textLabel.textColor = [BBConstantAndColor applicationGrayColor];
        } else {
            cell.textLabel.text = [self.replacement objectAtIndex:indexPath.section];
        }
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"Молоко #%ld", (long)indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.kType == kAddReplacementType) {
        BBAccessoryTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self.output cellDidSelectWithText:cell.textLabel.text];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.kType == kViewReplacementType) {
        if ([self.replacement count] != 0) {
            return UITableViewCellEditingStyleDelete;
        }
    }
    return UITableViewCellEditingStyleNone;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Удалить";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.indexPath = indexPath;
        BBAccessoryTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self.output deleteElementWithText:cell.textLabel.text];
    }
}


#pragma mark - Lazy Load

- (UIBarButtonItem *)rightBarButton {
    if (!_rightBarButton) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(_addBarButtonAction)];
        _rightBarButton.tintColor = [BBConstantAndColor applicationGrayColor];
    }
    return _rightBarButton;
}

@end