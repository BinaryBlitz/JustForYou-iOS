//
//  BBMapViewController.m
//  JustForYou
//
//  Created by tercteberc on 25/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBMapViewController.h"

#import "BBMapViewOutput.h"

@interface BBMapViewController()

@end

@implementation BBMapViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBMapViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleMapModule;
}

@end