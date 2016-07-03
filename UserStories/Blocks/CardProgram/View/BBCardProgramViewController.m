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

#import "BBDay.h"

@interface BBCardProgramViewController() <UITabBarDelegate, UITableViewDataSource, BBHeaderTableViewCellDelegate, BBNumberDayTableViewCell, BBAddBasketViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addInBasketButton;
@property (weak, nonatomic) IBOutlet UIView *gradientVIew;
@property (weak, nonatomic) IBOutlet UIView *addInBasketView;

@property (strong, nonatomic) BBProgram *myProgram;
@property (strong, nonatomic) RLMResults *daysInProgram;

@property (strong, nonatomic) BBDay *currentDay;
@property (strong, nonatomic) RLMResults *currentMenu;
@property (nonatomic) NSInteger positionDay;

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
    [self.output viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.addBasketPopover removeFromSuperview];
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

- (void)updateViewWithProgram:(NSInteger)programId {
    self.myProgram = [BBProgram objectsWhere:@"programId=%d", programId].firstObject;
    self.daysInProgram = self.myProgram.days;
    self.positionDay = 1;
    [self _updateCurrentDay];
    HQDispatchToMainQueue(^{
        [self.tableView reloadData];
    });
}

- (void)_updateCurrentDay {
    self.currentDay = [self.daysInProgram objectsWhere:[NSString stringWithFormat:@"position=%ld", (long)self.positionDay]].firstObject;
    RLMResults *res = self.currentDay.items;
    self.currentMenu = [res sortedResultsUsingProperty:[NSString stringWithFormat:@"startsHour"] ascending:YES];
}

- (void)showAddInBasketPopover {
    [self.view addSubview:self.addBasketPopover];
}

- (void)changeImageAndPresentAlertControllerWithMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle {
//    self.addInBasketButton.enabled = NO;
    [self.addBasketPopover removeFromSuperview];
    
    [self presentAlertControllerWithTitle:@"" message:message titleCancel:cancelTitle];
}

- (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
}

- (void)updateBasketButtonImageWithImageName:(NSString *)name {
    self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameForWhomCell bundle:nil]
         forCellReuseIdentifier:kForWhomCellIdentifire];
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
    NSInteger cells = 0;
    if (self.currentDay.morningMenu > 0) {
        cells++;
    }
    if (self.currentDay.dayMenu > 0) {
        cells++;
    }
    if (self.currentDay.eveningMenu > 0) {
        cells++;
    }
    NSInteger sum = cells + self.currentDay.morningMenu + self.currentDay.dayMenu + self.currentDay.eveningMenu;
    return sum;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        BBHeaderTableViewCell *headerCell = [self.tableView dequeueReusableCellWithIdentifier:kHeaderCellIdentifire];
        headerCell.delegate = self;
        [[BBImageViewService sharedService] setImageForImageView:headerCell.imageProgram placeholder:[UIImage imageNamed:@"testBack"] stringURL:self.myProgram.previewImage];
        
        return headerCell;
    }
    if (indexPath.section == 1) {
        
        if (self.segmentedIndex == BBDescriptionSegmentedIndex) {
            BBDescriptionTableViewCell *descriptiomCell = [self.tableView dequeueReusableCellWithIdentifier:kDescriptionCellIdentifire];
            [descriptiomCell reloadUIWithProgram:self.myProgram];
            return descriptiomCell;
        } else if (self.segmentedIndex == BBForWhomSegmentedIndex) {
            BBForWhomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kForWhomCellIdentifire];
            [cell setDescriptions:self.myProgram.firstPrescription :self.myProgram.secondPrescription :self.myProgram.thirdPrescription];
            return cell;
        } else {
            BBNumderDayTableViewCell *numberCell = [self.tableView dequeueReusableCellWithIdentifier:kNumberDayCellIdentifire];
            [numberCell setDaysAndUpdateUI:self.daysInProgram];
            if (!numberCell.delegate) {
                numberCell.delegate = self;
            }
            [numberCell updateDayLabelWithNumber:self.currentDay.position];
            self.numberDayCell = numberCell;
            return numberCell;
        }
    } else {
        if (indexPath.row == 0 || indexPath.row == self.currentDay.morningMenu+1 || indexPath.row == self.currentDay.morningMenu+1+self.currentDay.dayMenu+1) {
            BBPartDayTableViewCell *partDayCell = [self.tableView dequeueReusableCellWithIdentifier:kPartDayCellIdentifire];
            if (indexPath.row == 0) {
                [partDayCell setPartOfDayWithKey:kMorningPartOfDay];
            } else if (indexPath.row == self.currentDay.morningMenu+1) {
                [partDayCell setPartOfDayWithKey:kDayPartOfDay];
            } else {
                [partDayCell setPartOfDayWithKey:kEveningPartOfDay];
            }
            return partDayCell;
        } else {
            BBMenuTableViewCell *menuCell = [[NSBundle mainBundle] loadNibNamed:kNibNameMenuCell owner:self options:nil].lastObject;
            if (indexPath.row < self.currentDay.morningMenu+1) {
                [menuCell setMenuWithMenu:[self.currentMenu objectAtIndex:indexPath.row-1]];
            } else if (indexPath.row < self.currentDay.morningMenu+1+self.currentDay.dayMenu+1) {
                [menuCell setMenuWithMenu:[self.currentMenu objectAtIndex:indexPath.row-2]];
            } else {
                [menuCell setMenuWithMenu:[self.currentMenu objectAtIndex:indexPath.row-3]];
            }
            return menuCell;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    NSInteger oldSeg = self.segmentedIndex;
    self.segmentedIndex = segmentedIndex;
    [self _changeBackgroundTableView];
    if (segmentedIndex == BBDescriptionSegmentedIndex) {
        [self _updateTableViewWithIndex:1 range:2 animation:UITableViewRowAnimationRight];
    } else if (segmentedIndex == BBMenuSegmentedIndex) {
        if (oldSeg < self.segmentedIndex) {
            [self _updateTableViewWithIndex:1 range:2 animation:UITableViewRowAnimationLeft];
        } else {
            [self _updateTableViewWithIndex:1 range:2 animation:UITableViewRowAnimationRight];
        }
    } else {
        [self _updateTableViewWithIndex:1 range:2 animation:UITableViewRowAnimationLeft];
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
    if (self.positionDay > 1) {
        self.positionDay--;
        [self _updateCurrentDay];
        [self.numberDayCell updateDayLabelWithNumber:self.positionDay];
        [self _updateTableViewWithIndex:2 range:1 animation:UITableViewRowAnimationRight];
    } else {
    }
}

- (void)rightButtonDidTap {
    if (self.positionDay < [self.daysInProgram count]) {
        self.positionDay++;
        [self _updateCurrentDay];
        [self.numberDayCell updateDayLabelWithNumber:self.positionDay];
        [self _updateTableViewWithIndex:2 range:1 animation:UITableViewRowAnimationLeft];
    }
}

- (void)okButtonDidTapWithCountDays:(NSInteger)count {
    [self.output okButtonDidTapWithCountDays:count];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.addBasketPopover.popoverView];
    if (![self.addBasketPopover.popoverView pointInside:touchLocation withEvent:event]) {
        [self.addBasketPopover removeFromSuperview];
    }
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