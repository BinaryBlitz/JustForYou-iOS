//
//  BBNewOrderViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 06/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBNewOrderViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;

- (void)countDayCellDidTap;
- (void)adresCellDidTap;

- (void)toOrderButtonDidTapWithComment:(NSString *)comment startHour:(NSInteger)hour startMinute:(NSInteger)minute;

- (void)alertOkDidTap;

@end