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

@property (weak, nonatomic) IBOutlet UIButton *callManagerButton;
@property (weak, nonatomic) IBOutlet UIButton *writeManagerButton;
@property (weak, nonatomic) IBOutlet BBDottedBorderButton *feedbackButton;

@end

@implementation BBSupportViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions Mathods
- (IBAction)callManagerButtonAction:(id)sender {
    
}

- (IBAction)writeManagerButtonAction:(id)sender {
}


- (IBAction)feedbackButtonAction:(id)sender {
    
}

#pragma mark - Методы BBSupportViewInput

- (void)setupInitialState {
    self.navigationItem.title = @"Поддержка";
    [self _setTitleForButtons];
}

#pragma mark - Settings Methods

- (void)_setTitleForButtons {
    self.callManagerButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.callManagerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.callManagerButton setTitle:@"Позвонить\nменеджеру" forState:UIControlStateNormal];
    self.writeManagerButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.writeManagerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.writeManagerButton setTitle:@"Написать\nменеджеру" forState:UIControlStateNormal];
}

@end