//
//  BBCardProgramViewController.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramViewController.h"

#import "BBCardProgramViewOutput.h"

#import "BBHeaderTableViewCell.h"
#import "BBDescriptionTableViewCell.h"
#import "BBMenuTableViewCell.h"

@interface BBCardProgramViewController() <UITabBarDelegate, UITableViewDataSource, BBHeaderTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addInBasketButton;
@property (weak, nonatomic) IBOutlet UIView *gradientVIew;
@property (weak, nonatomic) IBOutlet UIView *addInBasketView;

@property (nonatomic) BBCardProgramSegmentedIndex segmentedIndex;
@property (nonatomic) CGFloat heightGradient;

@end

static NSString *kHeaderCellIdentifire = @"headerTableViewCell";
static NSString *kDescriptionCellIdentifire = @"descriptionTableViewCell";
static NSString *kMenuCellIdentifire = @"menuTableViewCell";

@implementation BBCardProgramViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self _registrateIdentifireCell];
	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self _layoutBasketButton];
}

#pragma mark - Методы BBCardProgramViewInput

- (void)setupInitialState {
    self.segmentedIndex = BBDescriptionSegmentedIndex;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
}

#pragma mark - Actions


- (IBAction)addInBasketButtonAction:(id)sender {
    
}


#pragma mark - TableView

- (void) _registrateIdentifireCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:kHeaderCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:@"BBDescriptionTableViewCell" bundle:nil] forCellReuseIdentifier:kDescriptionCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:@"BBMenuTableViewCell" bundle:nil] forCellReuseIdentifier:kMenuCellIdentifire];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        BBHeaderTableViewCell *headerCell = [self.tableView dequeueReusableCellWithIdentifier:kHeaderCellIdentifire];
        headerCell.delegate = self;
        headerCell.imageProgram.image = [UIImage imageNamed:@"testBack"];
        
        cell = headerCell;
    } else {
        if (self.segmentedIndex == BBDescriptionSegmentedIndex) {
            BBDescriptionTableViewCell *descriptiomCell = [self.tableView dequeueReusableCellWithIdentifier:kDescriptionCellIdentifire];
            descriptiomCell.descriptionLabel.text = @"dvabhsdbhsdbjhcbdsjhvdshjbjhdsbhdsbcjhdskcbdsjhbcjhdsbjhcbdsdvabhsdbhsdbjhcbdsjhvdshjbjhdsbhdsbcjhdskcbdsjhbcjhdsbjhcbdvabhsdbhsdbjhcbdsjhvdshjbjhdsbhdsbcjhdskcbdsjhbcjhdsbjhcbdsdvabhsdbhsdbjhcbdsjhvdshjbjhdsbhdsbcjhdskcbdsjhbcjhdsbjhcbdvabhsdbhsdbjhcbdsjhvdshjbjhdsbhdsbcjhdskcbdsjhbcjhdsbjhcbdsdvabhsdbhsdbjhcbdsjhvdshjbjhdsbhdsbcjhdskcbdsjhbcjhdsbjhcb";
            cell = descriptiomCell;
        } else {
            BBMenuTableViewCell *menuCell = [self.tableView dequeueReusableCellWithIdentifier:kMenuCellIdentifire];
            cell = menuCell;
        }
    }
    return cell;
}

#pragma mark - Controls TableView

- (void)segmentedControlValueChange:(BBCardProgramSegmentedIndex) segmentedIndex {
    self.segmentedIndex = segmentedIndex;
//    [self.tableView reloadData];
    NSRange range = NSMakeRange(1, 1);
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Layout Views

- (void)_layoutBasketButton {
    [self.addInBasketButton.layer setMasksToBounds:YES];
    [self.addInBasketButton.layer setCornerRadius:CGRectGetHeight(self.addInBasketButton.frame)/2];
}


@end