//
//  BBStockViewController.m
//  JustForYou
//
//  Created by tercteberc on 19/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBStockViewController.h"

#import "BBStockViewOutput.h"

@interface BBStockViewController()

@property (strong, nonatomic) BBStock *stock;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BBStockViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBStockViewInput

- (void)setupInitialState {
}

- (void)stockForUI:(BBStock *)stock {
    self.stock = stock;
    self.navigationItem.title = self.stock.name;
    self.textView.text = self.stock.descript;
}

@end