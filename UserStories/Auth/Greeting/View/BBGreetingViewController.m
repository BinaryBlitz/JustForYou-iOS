//
//  BBGreetingViewController.m
//  JustForYou
//
//  Created by tercteberc on 17/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBGreetingViewController.h"

#import "BBGreetingViewOutput.h"

@interface BBGreetingViewController()

@end

@implementation BBGreetingViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBGreetingViewInput

- (void)setupInitialState {
	
}

@end