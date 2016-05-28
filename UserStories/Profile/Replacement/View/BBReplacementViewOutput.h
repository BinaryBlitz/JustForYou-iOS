//
//  BBReplacementViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBReplacementViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)addBarButtonDidTap;

- (void)deleteElementWithText:(NSString *)text;

- (void)cellDidSelectWithText:(NSString *)text;

@end