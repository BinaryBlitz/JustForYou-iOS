//
//  BBSupportViewController.m
//  JustForYou
//
//  Created by tercteberc on 29/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBSupportViewController.h"

#import "BBSupportViewOutput.h"

#import "BBDottedBorderButton.h"

@interface BBSupportViewController()

@property (weak, nonatomic) IBOutlet BBDottedBorderButton *feedbackButton;

@end

@implementation BBSupportViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions Mathods

- (IBAction)feedbackButtonAction:(id)sender {
    
}

#pragma mark - Методы BBSupportViewInput

- (void)setupInitialState {
    
}

#pragma mark - Settings Methods


@end