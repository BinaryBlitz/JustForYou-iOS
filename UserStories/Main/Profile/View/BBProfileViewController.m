//
//  BBProfileViewController.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProfileViewController.h"

#import "BBProfileViewOutput.h"

@interface BBProfileViewController()

@end

@implementation BBProfileViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBProfileViewInput

- (void)setupInitialState {
	
}

@end