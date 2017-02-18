//
//  BBCardProgramViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCardProgramViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)basketButtonDidTap;

- (void)addToBasketButtonDidTapWithProgram:(BBProgram *)program;

- (void)okButtonDidTapWithCountDays:(NSInteger)count;

@end
