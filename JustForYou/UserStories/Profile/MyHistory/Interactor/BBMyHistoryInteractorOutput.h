//
//  BBMyHistoryInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 25/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBMyHistoryInteractorOutput <NSObject>

- (void)ordersWithArray:(NSArray *)orders;

- (void)errorNetwork;
- (void)errorServer;

@end