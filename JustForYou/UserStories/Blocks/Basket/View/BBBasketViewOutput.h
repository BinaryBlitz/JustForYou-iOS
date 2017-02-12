//
//  BBBasketViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBPayCard.h"

@protocol BBBasketViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)removeButtonDidTapWithOrderProgram:(BBOrderProgram *)order;

- (void)closeButtonDidTap;
- (void)payButtonDidTapWithBonusesEnable:(BOOL)enable countPayments:(NSInteger)count;

- (void)changeStateWithState:(BOOL)state;

- (void)payNewCardButtonDidTap;
- (void)payCardWithCard:(BBPayCard *)card;
- (void)cancelButtonDidTap;

- (void)okCancelButtonDidTap;

@end
