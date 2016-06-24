//
//  BBUniversalInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBUniversalInteractorInput <NSObject>

#pragma mark - Address

- (void)currentAddressArray;

- (void)deleteAddress:(BBAddress *)address;

#pragma mark - Stock

- (void)listShares;

#pragma  mark - PayCard

- (NSArray *)currentPayCards;

- (void)listPayCardsUser;

@end
