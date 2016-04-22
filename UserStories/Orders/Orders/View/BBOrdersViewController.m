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

#import <JTCalendar/JTCalendar.h>


@interface BBOrdersViewController() 

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarView;

@property (strong, nonatomic) UIBarButtonItem *leftBarButton;
@property (strong, nonatomic) UIBarButtonItem *rightBarButton;
@property (strong, nonatomic) BBCalendarMenuView *calendarMenu;

@end

@implementation BBOrdersViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions 

- (void)_leftBarButtonAction {
    
}

- (void)_rightBarButtonAction {
    
}

#pragma mark - Методы BBOrdersViewInput

- (void)setupInitialState {
    [self.output initCalendarManagerWithCalendarView:self.calendarView];
//    self.navigationItem.leftBarButtonItem = self.leftBarButton;
//    self.navigationItem.rightBarButtonItem = self.rightBarButton;
    
    self.navigationItem.titleView = self.calendarMenu;
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)updateNameMonthPreviousName:(NSString *)previousName currentName:(NSString *)currentName nextName:(NSString *)nextName {
//    self.leftBarButton.title = previousName;
//    self.navigationItem.title = currentName;
//    self.rightBarButton.title = nextName;
    self.calendarMenu.titleLabel.text = currentName;
}
#pragma mark - Lazy Load

- (BBCalendarMenuView *) calendarMenu {
    if (!_calendarMenu) {
        _calendarMenu = [[BBCalendarMenuView alloc] initWithFrame:CGRectMake(0,0,100,32)];
    }
    return _calendarMenu;
}

- (UIBarButtonItem *) leftBarButton {
    if (!_leftBarButton) {
        _leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(_leftBarButtonAction)];
        _leftBarButton.tintColor = [BBConstantAndColor applicationGrayColor];
    }
    return _leftBarButton;
}

- (UIBarButtonItem *) rightBarButton {
    if (!_rightBarButton) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(_rightBarButtonAction)];
        _rightBarButton.tintColor = [BBConstantAndColor applicationGrayColor];
    }
    return _rightBarButton;
}

@end