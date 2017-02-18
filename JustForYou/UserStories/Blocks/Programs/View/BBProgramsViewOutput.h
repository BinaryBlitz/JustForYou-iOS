//
//  BBProgramsViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBProgram.h"

@protocol BBProgramsViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)programDidTapWithProgram:(NSInteger)programId;

- (void)addToBasketButtonDidTapWithProgram:(BBProgram *)program;

- (void)okButtonDidTapWithCountDays:(NSInteger)count program:(BBProgram *)program;

- (void)errorOpenProgram;

- (void)basketButtonDidTap;

- (void)viewWillAppear;

@end
