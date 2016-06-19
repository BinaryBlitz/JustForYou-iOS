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

@end