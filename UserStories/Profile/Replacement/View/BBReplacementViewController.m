//
//  BBReplacementViewController.m
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplacementViewController.h"

#import "BBReplacementViewOutput.h"

@interface BBReplacementViewController()

@end

@implementation BBReplacementViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBReplacementViewInput

- (void)setupInitialState {
	
}

@end