//
//  BBCardProgramViewController.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramViewController.h"

#import "BBCardProgramViewOutput.h"

#import "BBAddBasketViewPopover.h"

@interface BBCardProgramViewController() <UITabBarDelegate, UITableViewDataSource, BBHeaderTableViewCellDelegate, BBNumberDayTableViewCell, BBAddBasketViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addInBasketButton;
@property (weak, nonatomic) IBOutlet UIView *gradientVIew;
@property (weak, nonatomic) IBOutlet UIView *addInBasketView;

@property (strong, nonatomic) BBProgram *myProgram;

@property (strong, nonatomic) BBAddBasketViewPopover *addBasketPopover;

@property (strong, nonatomic) BBNumderDayTableViewCell *numberDayCell;

@property (nonatomic) BBCardProgramSegmentedIndex segmentedIndex;
@property (nonatomic) CGFloat heightGradient;

@end

@implementation BBCardProgramViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self _registrateIdentifireCell];
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self _layoutBasketButton];
}


#pragma mark - Actions

- (void)_basketButtonAction {
    [self.output basketButtonDidTap];
}


- (IBAction)addInBasketButtonAction:(id)sender {
    [self.output addInBasketButtonDidTap];
}

#pragma mark - Методы BBCardProgramViewInput

- (void)setupInitialState {
    self.segmentedIndex = BBDescriptionSegmentedIndex;
    [self _settingTableView];
    [self _initRightBarButton];
}

- (void)updateViewWithProgram:(BBProgram *)program {
//    self.myProgram = program;
}

- (void)showAddInBasketPopover {
    [self.view addSubview:self.addBasketPopover];
}

- (void)changeImageAndPresentAlertControllerWithMessage:(NSString *)message {
//    self.addInBasketButton.enabled = NO;
    [self.addBasketPopover removeFromSuperview];
    self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"basketFull"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.alertController.message = message;
    [self presentAlertControllerWithTitle:@"" message:message];
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

#pragma mark - TableView Methods

- (void) _registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameHeaderCell bundle:nil]
         forCellReuseIdentifier:kHeaderCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameDescriptionCell bundle:nil]
         forCellReuseIdentifier:kDescriptionCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameMenuCell bundle:nil]
         forCellReuseIdentifier:kMenuCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNamePartDayCell bundle:nil]
         forCellReuseIdentifier:kPartDayCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameNumberDayCell bundle:nil]
         forCellReuseIdentifier:kNumberDayCellIdentifire];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (self.segmentedIndex == BBDescriptionSegmentedIndex || self.segmentedIndex == BBForWhomSegmentedIndex) {
        return 0;
    }
    return 7;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        BBHeaderTableViewCell *headerCell = [self.tableView dequeueReusableCellWithIdentifier:kHeaderCellIdentifire];
        headerCell.delegate = self;
        headerCell.imageProgram.image = [UIImage imageNamed:@"testBack"];
        
        return headerCell;
    }
    if (indexPath.section == 1) {
        
        if (self.segmentedIndex == BBDescriptionSegmentedIndex) {
            BBDescriptionTableViewCell *descriptiomCell = [self.tableView dequeueReusableCellWithIdentifier:kDescriptionCellIdentifire];
            descriptiomCell.nameLabel.text = @"1300 ккал без мяса и птицы";
            descriptiomCell.costLabel.text = @"5800 РУБ";
            descriptiomCell.descriptionLabel.text = @"Самый комфортный путь к стройности для тех, кто предпочитает исключать из рациона мясо и птицу.\n\nПрограмма «1300 Ккал без мяса и птицы» – сбалансированная программа с низким содержанием сахара, без блюд из мяса и птицы. Может использоваться в качестве ";
            return descriptiomCell;
        } else {
            BBNumderDayTableViewCell *numberCell = [self.tableView dequeueReusableCellWithIdentifier:kNumberDayCellIdentifire];
            if (!numberCell.delegate) {
                numberCell.delegate = self;
            }
            self.numberDayCell = numberCell;
            return numberCell;
        }
    } else {
        if (indexPath.row == 0 || indexPath.row == 4) {
            BBPartDayTableViewCell *partDayCell = [self.tableView dequeueReusableCellWithIdentifier:kPartDayCellIdentifire];
            if (indexPath.row == 0) {
                [partDayCell setPartOfDayWithKey:kMorningPartOfDay];
            } else {
                [partDayCell setPartOfDayWithKey:kDayPartOfDay];
            }
            return partDayCell;
        } else {
            BBMenuTableViewCell *menuCell = [[NSBundle mainBundle] loadNibNamed:kNibNameMenuCell owner:self options:nil].lastObject;
            
            return menuCell;
        }
    }
    
}

- (void)_settingTableView {
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
}

- (void)_updateTableViewWithIndex:(NSInteger)index range:(NSInteger)range animation:(UITableViewRowAnimation)animation {
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, range)];
    [self.tableView beginUpdates];
    [self.tableView reloadSections:section withRowAnimation:animation];
    [self.tableView endUpdates];
}

#pragma mark - Controls TableView

- (void)segmentedControlValueChange:(BBCardProgramSegmentedIndex)segmentedIndex {
    self.segmentedIndex = segmentedIndex;
    [self _changeBackgroundTableView];
    if (segmentedIndex == BBMenuSegmentedIndex) {
        [self _updateTableViewWithIndex:1 range:2 animation:UITableViewRowAnimationLeft];
    } else if (segmentedIndex == BBDescriptionSegmentedIndex) {
        [self _updateTableViewWithIndex:1 range:2 animation:UITableViewRowAnimationRight];
    } else {
        
    }
}

- (void)_changeBackgroundTableView {
    if (self.segmentedIndex == BBDescriptionSegmentedIndex) {
        self.tableView.backgroundColor = [UIColor whiteColor];
    } else {
        self.tableView.backgroundColor = [BBConstantAndColor colorForR:250 G:250 B:250 alpha:1.f];
    }
}

#pragma mark - Cell Delegates Methods 

- (void)leftButtonDidTap {
    self.numberDayCell.numberDay--;
    if (self.numberDayCell.numberDay < 1) {
        self.numberDayCell.numberDay++;
    } else {
        [self.numberDayCell updateDayLabelWithNumber:self.numberDayCell.numberDay];
        [self _updateTableViewWithIndex:2 range:1 animation:UITableViewRowAnimationRight];
    }
}

- (void)rightButtonDidTap {
    self.numberDayCell.numberDay++;
    [self.numberDayCell updateDayLabelWithNumber:self.numberDayCell.numberDay];
    [self _updateTableViewWithIndex:2 range:1 animation:UITableViewRowAnimationLeft];
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count {
    [self.output okButtonDidTapWithCountDays:count];
}

#pragma mark - Init Methods

- (void)_initRightBarButton {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"basket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(_basketButtonAction)];
    
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - Layout Views

- (void)_layoutBasketButton {
    [self.addInBasketButton.layer setMasksToBounds:YES];
    [self.addInBasketButton.layer setCornerRadius:CGRectGetHeight(self.addInBasketButton.frame)/2];
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