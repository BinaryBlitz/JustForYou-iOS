//
//  BBNewOrderViewController.m
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBNewOrderViewController.h"

#import "BBNewOrderViewOutput.h"

@interface BBNewOrderViewController()

@end

@implementation BBNewOrderViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBNewOrderViewInput

- (void)setupInitialState {
	
}

@end