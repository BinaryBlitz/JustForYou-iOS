//
//  BBListMyProgViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBListMyProgViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)okButtonDidTapWithCountDays:(NSInteger)count programId:(NSInteger)programId;

@end