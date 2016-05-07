//
//  BBBasketViewController.m
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBasketViewController.h"

#import "BBBasketViewOutput.h"

@interface BBBasketViewController()

@end

@implementation BBBasketViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBBasketViewInput

- (void)setupInitialState {
	
}

@end