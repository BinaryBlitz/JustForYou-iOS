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

#pragma mark - Actions


- (void)nextButtonAction {
    [self.output nextButtonDidTap];
}

#pragma mark - Методы BBRegistrationViewInput

- (void)setupInitialState {
    [self createBarButtonItem];
}


- (void)createBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Продолжить"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(nextButtonAction)];
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (BBUser *)userWithTextFields {
    BBUser *user = nil;
    
    return user;
}

@end