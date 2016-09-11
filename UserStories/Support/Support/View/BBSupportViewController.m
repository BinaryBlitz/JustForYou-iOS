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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *instagramButton;

@end

static CGFloat bottomInsetIphone5 = 80.0f;
static CGFloat bottomInsetIphone4 = 168.0f;
static CGFloat heightIPhone5 = 568.0f;
static CGFloat heightIPhone4 = 480.0f;

@implementation BBSupportViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Actions Mathods

- (IBAction)callManagerButtonAction:(id)sender {
    [self.output callManagerButtonDidTap];
}

- (IBAction)writeManagerButtonAction:(id)sender {
    [self _stopTapControlsWithTimer];
    [self.output writeManagerButtonDidTap];
}


- (IBAction)feedbackButtonAction:(id)sender {
    [self _stopTapControlsWithTimer];
    [self.output feedbackButtonDidTap];
}

- (IBAction)facebookButtonAction:(id)sender {
    [self.output facebookButtonDidTap];
}

- (IBAction)instagramButtonAction:(id)sender {
    [self.output instagramButtonDidTap];
}


- (void)_stopTapControlsWithTimer {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    double delayInSecond = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}

#pragma mark - Методы BBSupportViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitleSupportModule;
    [self _setTitleForButtons];
    [self _settingScrollView];
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertControllerWithTitle:title message:message];
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

- (void)_settingScrollView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (screenRect.size.height == heightIPhone5) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, bottomInsetIphone5, 0);
    } else if (screenRect.size.height == heightIPhone4) {
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, bottomInsetIphone4, 0);
    }else {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
}

@end