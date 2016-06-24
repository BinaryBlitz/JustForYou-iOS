//
//  BBUniversalInteractorOutput.h
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBUniversalInteractorOutput <NSObject>

- (void)currentAddressArray:(NSArray *)addressArray;
- (void)currentAddressArrayWithDeletedAddress:(NSArray *)array;

- (void)currentSharesWithArray:(NSArray *)array;

- (void)currentPayCardsUserWithArray:(NSArray *)array;

- (void)errorNetwork;
- (void)errorServer;

@end
