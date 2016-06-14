//
//  BBBasketViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBBasketViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)closeButtonDidTap;
- (void)payButtonDidTap;

@end
