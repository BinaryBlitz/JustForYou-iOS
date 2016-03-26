//
//  BBRegistrationViewController.m
//  JustForYou
//
//  Created by tercteberc on 26/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBRegistrationViewController.h"

#import "BBRegistrationViewOutput.h"

@interface BBRegistrationViewController()

@property (weak, nonatomic) IBOutlet UIView *youView;

@end

@implementation BBRegistrationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewDidLayoutSubviews {
    [self layoutYouView];
}

#pragma mark - Методы BBRegistrationViewInput

- (void)setupInitialState {
    
}

#pragma mark - Layout Views

- (void)layoutYouView {
    self.youView.layer.masksToBounds = YES;
    [self.youView.layer setCornerRadius:CGRectGetHeight(self.youView.frame)/2];
}


@end