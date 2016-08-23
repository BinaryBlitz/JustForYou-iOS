//
//  BBAddressViewController.m
//  JustForYou
//
//  Created by tercteberc on 21/08/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBAddressViewController.h"

#import "BBAddressViewOutput.h"

@interface BBAddressViewController()

@end

@implementation BBAddressViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

#pragma mark - Методы BBAddressViewInput

- (void)setupInitialState {
	
}

@end