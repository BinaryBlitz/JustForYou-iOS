//
//  BBUniversalViewController.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalViewController.h"

#import "BBUniversalViewOutput.h"

@interface BBUniversalViewController()

@end

@implementation BBUniversalViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBUniversalViewInput

- (void)setupInitialState {
	
}

@end