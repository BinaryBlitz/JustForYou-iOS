//
//  BBStockViewController.m
//  JustForYou
//
//  Created by tercteberc on 19/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBStockViewController.h"

#import "BBStockViewOutput.h"
#import "BBCalendarService.h"

@interface BBStockViewController()

@property (strong, nonatomic) BBStock *stock;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BBStockViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[BBAppAnalitics sharedService] sendControllerWithName:self.stock.name];
}

- (void)viewWillLayoutSubviews {
    self.navigationItem.title = self.stock.name;
    self.textView.text = self.stock.descript;
    self.dateLabel.text = [[BBCalendarService sharedService] dateForUIWithDate:self.stock.date];
}

#pragma mark - Методы BBStockViewInput

- (void)setupInitialState {
}

- (void)stockForUI:(BBStock *)stock {
    self.stock = stock;
}

@end
