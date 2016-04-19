//
//  BBOrdersViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersViewController.h"

#import "BBOrdersViewOutput.h"

#import <JTCalendar/JTCalendar.h>

@interface BBOrdersViewController() 

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong, nonatomic) UIBarButtonItem *leftBarButton;
@property (strong, nonatomic) UIBarButtonItem *rightBarButton;

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
//    [self.output initCalendarManagerWithCalendarView:self.calendarView previousLabel: currentLabel:<#(UILabel *)#> netxLabel:<#(UILabel *)#>];
}


#pragma mark - Lazy Load

- (UIBarButtonItem *) leftBarButton {
    if (!_leftBarButton) {
        _leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(_leftBarButtonAction)];
    }
    return _leftBarButton;
}

- (UIBarButtonItem *) rightBarButton {
    if (!_rightBarButton) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(_rightBarButtonAction)];
    }
    return _rightBarButton;
}

@end