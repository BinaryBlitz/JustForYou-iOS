//
//  BBDeliveryViewController.m
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBDeliveryViewController.h"

#import "BBDeliveryViewOutput.h"

@interface BBDeliveryViewController()

@end

@implementation BBDeliveryViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBDeliveryViewInput

- (void)setupInitialState {
	
}

@end