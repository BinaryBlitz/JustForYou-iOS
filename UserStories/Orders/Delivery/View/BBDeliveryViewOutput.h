//
//  BBDeliveryViewOutput.h
//  JustForYou
//
//  Created by tercteberc on 11/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBDeliveryViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)viewWillAppear;
- (void)viewWillDisappear;

@end