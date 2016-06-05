//
//  BBAuthorizationViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBAuthorizationViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)nextButtonDidPress;

- (void)backButtonDidTap;

- (void)codeUser:(NSString *)code;

- (void)sendCodeButtonDidTapWithValidField:(BOOL)valid andNumberPhone:(NSString *)primaryNumber;
- (void)sengAgainButtonDidTap;

@end