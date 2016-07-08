//
//  BBOrdersInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBOrdersInteractorInput <NSObject>

- (void)listMyDeliveriesOnDataBase;
- (void)myDeliveriesOnServer;

- (void)listPurchasesUser;

- (void)checkMyDeliveryInvoices;
- (void)payDeliveriesWithTotal:(NSInteger)total invoicesId:(NSInteger)invoicesId card:(BBPayCard *)card;
- (void)payOnServerWithPayCard:(BBPayCard *)card paiId:(NSInteger)paiId;

@end