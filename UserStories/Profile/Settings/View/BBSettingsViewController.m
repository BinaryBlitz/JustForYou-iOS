//
//  BBSettingsViewController.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSettingsViewController.h"

#import "BBSettingsViewOutput.h"

@interface BBSettingsViewController()

@end

@implementation BBSettingsViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBSettingsViewInput

- (void)setupInitialState {
	
}

@end