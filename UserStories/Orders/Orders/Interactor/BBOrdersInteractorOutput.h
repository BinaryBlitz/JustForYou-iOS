//
//  BBOrdersInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBOrdersInteractorOutput <NSObject>

- (void)currentMyDeliveriesWithArray:(NSArray *)array;
- (void)updateDeliveriesWithArray:(NSArray *)array;

- (void)errorNetwork;
- (void)errorServer;

- (void)currentPurchasesUserWithArray:(NSArray *)array;

@end