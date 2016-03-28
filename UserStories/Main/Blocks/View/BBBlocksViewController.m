//
//  BBBlocksViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksViewController.h"

#import "BBBlocksViewOutput.h"

@interface BBBlocksViewController()

@end

@implementation BBBlocksViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBBlocksViewInput

- (void)setupInitialState {
	
}

@end