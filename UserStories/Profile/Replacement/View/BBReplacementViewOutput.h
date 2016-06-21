//
//  BBReplacementViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBReplacementCategory.h"

@protocol BBReplacementViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)addBarButtonDidTap;

- (void)deleteElementWithText:(BBReplacementProduct *)product;

- (void)cellDidSelectWithText:(BBReplacementProduct *)product;

@end