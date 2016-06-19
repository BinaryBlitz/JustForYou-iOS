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

@implementation BBUniversalInteractor

#pragma mark - Методы BBUniversalInteractorInput

- (void)currentAddressArray {
    BBUser *user = [[BBUserService sharedService] currentUser];
    [self.output currentAddressArray:user.addressArray];
}

- (NSArray *)deleteAddress:(BBAddress *)address {
    [[BBUserService sharedService] deleteAddressOnUser:address];
    return [[BBUserService sharedService] currentUser].addressArray;
}

- (void)listShares {
    [[BBServerService sharedService] listStocksWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        [self.output currentSharesWithArray:objects];
    }];
}

@end
