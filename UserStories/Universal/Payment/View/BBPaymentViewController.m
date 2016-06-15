//
//  BBPaymentViewController.m
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBPaymentViewController.h"

#import "BBPaymentViewOutput.h"

@interface BBPaymentViewController() <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BBPaymentViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - Методы BBPaymentViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitlePaymentModule;
}

- (void)loadWebViewWithPayment:(BBPayment *)payment {
    NSURL *url = [NSURL URLWithString:payment.paymentURL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
