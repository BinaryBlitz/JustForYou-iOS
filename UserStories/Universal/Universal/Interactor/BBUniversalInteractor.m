//
//  BBUniversalInteractor.m
//  JustForYou
//
//  Created by tercteberc on 22/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBUniversalInteractor.h"

#import "BBUniversalInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@implementation BBUniversalInteractor

#pragma mark - Методы BBUniversalInteractorInput

#pragma mark - Address

- (void)currentAddressArray {
    BBUser *user = [[BBUserService sharedService] currentUser];
    [self.output currentAddressArray:user.addressArray];
}

- (NSArray *)deleteAddress:(BBAddress *)address {
    [[BBUserService sharedService] deleteAddressOnUser:address];
    return [[BBUserService sharedService] currentUser].addressArray;
}

#pragma mark - Stocks

- (void)listShares {
    [[BBServerService sharedService] listStocksWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        [self.output currentSharesWithArray:objects];
    }];
}

#pragma  mark - PayCard 

- (NSArray *)currentPayCards {
    return [[BBDataBaseService sharedService] curentPayCards];
}

- (void)listPayCardsUser {
    [[BBServerService sharedService] listPaymentCardsUserWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        if (response.responseCode == 200) {
            [[BBDataBaseService sharedService] addOrUpdatePayCardsUserWithArray:objects];
            [self.output currentPayCardsUserWithArray:[[BBDataBaseService sharedService] curentPayCards]];
        }
    }];
}

@end
