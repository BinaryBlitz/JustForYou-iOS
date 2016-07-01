//
//  BBReplaceProgramViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBReplaceProgramViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;
- (void)viewWillAppear;

- (void)cellDidSelectRowWithProgram:(BBProgram *)program;

- (void)okCancelButtonDidTapWithKey:(BBKeyForOkButtonAlert)key;

- (void)payNewCardButtonDidTap;
- (void)payCardWithCard:(BBPayCard *)card;

@end