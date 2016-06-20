//
//  BBPaymentViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 21/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBPaymentViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)webViewDidChangeURLWithURL:(NSURL *)url;

@end