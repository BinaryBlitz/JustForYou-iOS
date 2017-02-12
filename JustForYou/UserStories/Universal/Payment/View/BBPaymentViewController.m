//
//  BBPaymentViewController.m
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBPaymentViewController.h"

#import "BBPaymentViewOutput.h"

@import WebKit;
@interface BBPaymentViewController() <UIWebViewDelegate, WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation BBPaymentViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
    [[BBAppAnalitics sharedService] sendControllerWithName:kNameTitlePaymentModule];
}

#pragma mark - Методы BBPaymentViewInput

- (void)setupInitialState {
    self.navigationItem.title = kNameTitlePaymentModule;
}

- (void)loadWebViewWithPayment:(BBPayment *)payment {
    NSURL *url = [NSURL URLWithString:payment.paymentURL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.output webViewDidChangeURLWithURL:self.webView.URL];
}

#pragma mark - Lazy Load

- (WKWebView *)webView {
    if (!_webView) {
        
        // JS magic
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkWebConfig];
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
