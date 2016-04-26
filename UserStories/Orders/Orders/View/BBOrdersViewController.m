//
//  BBOrdersViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersViewController.h"

#import "BBOrdersViewOutput.h"

#import "BBCalendarMenuView.h"
#import "BBDottedBorderButton.h"

#import <JTCalendar/JTCalendar.h>


@interface BBOrdersViewController() <BBCalendarMenuViewDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarView;
@property (weak, nonatomic) IBOutlet BBDottedBorderButton *addNewOrderButton;

@property (strong, nonatomic) BBCalendarMenuView *calendarMenu;

@end

static CGFloat wightForCalendarMenuView = 140.0f;
static CGFloat heightForCalendarMenuView = 32.0f;

@implementation BBOrdersViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions 

- (IBAction)addNewOrderButtonAction:(id)sender {
    
}


#pragma mark - Методы BBOrdersViewInput

- (void)setupInitialState {
    [self.output initCalendarManagerWithCalendarView:self.calendarView];
    
    self.navigationItem.titleView = self.calendarMenu;
}

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
    self.calendarMenu.titleLabel.text = currentName;
}

#pragma mark - BBCalendarMenuViewDelegate

- (void)leftButtonDidTap {
    [self.output leftButtonDidTap];
}


- (void)rightButtonDidTap {
    [self.output rightButtonDidTap];
}

#pragma mark - Lazy Load

- (BBCalendarMenuView *) calendarMenu {
    if (!_calendarMenu) {
        _calendarMenu = [[BBCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, wightForCalendarMenuView, heightForCalendarMenuView)];
        _calendarMenu.delegate = self;
    }
    return _calendarMenu;
}

@end