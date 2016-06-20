//
//  BBPaymentPresenter.m
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBPaymentPresenter.h"

#import "BBPaymentViewInput.h"
#import "BBPaymentInteractorInput.h"
#import "BBPaymentRouterInput.h"

#import "BBNavigationModuleInput.h"

#import "BBBasketModuleInput.h"

@interface BBPaymentPresenter()

@property (strong, nonatomic) id<BBNavigationModuleInput> navigationModule;
@property (strong, nonatomic) id<BBBasketModuleInput> basketModule;

@property (strong, nonatomic) BBPayment *payment;

@end

@implementation BBPaymentPresenter

#pragma mark - Методы BBPaymentModuleInput

- (void)configureModule {
    
}

- (void)pushModuleWithNavigationModule:(id)navigationModule basketModule:(id)basketModule payment:(BBPayment *)payment {
    self.navigationModule = navigationModule;
    self.basketModule = basketModule;
    self.payment = payment;
    [self.router pushViewControllerWithNavigationController:[self.navigationModule currentView]];
}

#pragma mark - Методы BBPaymentViewOutput

- (void)didTriggerViewReadyEvent {
	[self.view setupInitialState];
    [self.view loadWebViewWithPayment:self.payment];
}

- (void)webViewDidChangeURLWithURL:(NSURL *)url {
    NSLog(@"%@", url);
    NSString *urlString = url.absoluteString;
    NSRange range = [urlString rangeOfString:@"success" options:NSLiteralSearch];
    NSLog(@"%@", NSStringFromRange(range));
    if (range.length > 3) {
        [self.basketModule paySucces];
    }
}

#pragma mark - Методы BBPaymentInteractorOutput

@end
