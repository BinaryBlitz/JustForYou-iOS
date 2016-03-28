//
//  BBOrdersViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBOrdersViewController.h"

#import "BBOrdersViewOutput.h"

@interface BBOrdersViewController()

@end

@implementation BBOrdersViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBOrdersViewInput

- (void)setupInitialState {
	
}

@end