//
//  BBRegistrationViewController.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationViewController.h"

#import "BBRegistrationViewOutput.h"

#import "BBUnderlineButton.h"

@interface BBRegistrationViewController()

@end

@implementation BBRegistrationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBRegistrationViewInput

- (void)setupInitialState {
    
}
@end