//
//  BBBasketInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 07/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBPayCard.h"

typedef enum : NSUInteger {
    kTypeNewPayment,
    kTypeCardPayment
}BBTypePayment;

@protocol BBBasketInteractorInput <NSObject>

- (void)currentOrdersInBasket;

- (NSArray *)deleteOrderProgramOnUserArray:(BBOrderProgram *)orderProgram;

- (void)deleteAllOrderProgramsOnUser;

- (void)createOrderOnServerWithTypePayment:(BBTypePayment)type payCard:(BBPayCard *)card useBonuses:(BOOL)use;

- (NSArray *)currentUserPayCards;

@end
