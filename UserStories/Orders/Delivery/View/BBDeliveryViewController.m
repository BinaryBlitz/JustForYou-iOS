//
//  BBDeliveryViewController.m
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBDeliveryViewController.h"

#import "BBDeliveryViewOutput.h"

#import "BBCalendarDeliveryTableViewCell.h"
#import "BBAccessoryTableViewCell.h"


@interface BBDeliveryViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *kNibNameCalendarDeliveryCell = @"BBCalendarDeliveryTableViewCell";
static NSString *kNibNameAccessoryCell = @"BBAccessoryTableViewCell";

static NSString *kCalendarDeliveryCellIdentifire = @"calendarDeliveryTableViewCell";
static NSString *kAccessoryCellIdentifire = @"accessoryTableViewCell";

static CGFloat estimatedRowHeight = 50.0f;

@implementation BBDeliveryViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBDeliveryViewInput

- (void)setupInitialState {
	
}

#pragma mark - TableView Methods


- (void)_registerCellIdentifireInTableView {
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameCalendarDeliveryCell bundle:nil]
         forCellReuseIdentifier:kCalendarDeliveryCellIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:kNibNameAccessoryCell bundle:nil]
         forCellReuseIdentifier:kAccessoryCellIdentifire];
}

- (void)_settingTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = estimatedRowHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        BBCalendarDeliveryTableViewCell *calendarCell = [self.tableView dequeueReusableCellWithIdentifier:kCalendarDeliveryCellIdentifire];
        cell = calendarCell;
    } else {
        BBAccessoryTableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:kAccessoryCellIdentifire];
        accessoryCell.accessoryType = UITableViewCellAccessoryNone;
        accessoryCell.setRadius = YES;
        accessoryCell.kSideCornerRadius = kAllCornerRadius;
        if (indexPath.row == 0) {
            accessoryCell.textLabel.text = @"Подряд";
        } else {
            accessoryCell.textLabel.text = @"Подряд без выходных";
        }
        cell = accessoryCell;
    }
    
    return cell;
}



@end