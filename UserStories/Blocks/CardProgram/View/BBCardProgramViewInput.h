//
//  BBCardProgramViewInput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCardProgramViewInput <NSObject>

- (void)setupInitialState;

- (void)changeImageAndPresentAlertControllerWithMessage:(NSString *)message;

@end