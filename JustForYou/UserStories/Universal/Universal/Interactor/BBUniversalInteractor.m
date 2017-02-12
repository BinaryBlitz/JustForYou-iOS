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

@interface BBUniversalInteractor()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation BBUniversalInteractor

#pragma mark - Методы BBUniversalInteractorInput

#pragma mark - Address

- (void)currentAddressArray {
    BBUser *user = [[BBUserService sharedService] currentUser];
    [self.output currentAddressArray:user.addressArray];
}

- (void)deleteAddress:(BBAddress *)address {
    __block BBAddress *addr = address;
    [[BBServerService sharedService] deleteAddressWithApiToken:[[BBUserService sharedService] tokenUser]
                                                     addressId:[NSString stringWithFormat:@"%ld", (long)address.addressId]
                                                    completion:^(BBServerResponse *response, NSError *error) {
                                                        if (response.kConnectionServer == kSuccessfullyConnection) {
                                                            if (response.serverError == kServerErrorSuccessfull) {
                                                                [[BBUserService sharedService] deleteAddressOnUser:addr];
                                                                [self.output currentAddressArrayWithDeletedAddress:[[BBUserService sharedService] currentUser].addressArray];
                                                            } else {
                                                                [self.output errorServer];
                                                            }
                                                        } else {
                                                            [self.output errorNetwork];
                                                        }
    }];
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
            HQDispatchToMainQueue(^{
                [[BBDataBaseService sharedService] addOrUpdatePayCardsUserWithArray:objects];
                [self.output currentPayCardsUserWithArray:[[BBDataBaseService sharedService] curentPayCards]];
            });
        }
    }];
}

- (void)deletePaymentCardWithCard:(BBPayCard *)card {
    __block BBPayCard *oldCard = card;
    [[BBServerService sharedService] deletePaymentCardWithApiToken:[[BBUserService sharedService] tokenUser] cardId:card.payCardId completion:^(BBServerResponse *response, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.serverError == kServerErrorSuccessfull) {
                HQDispatchToMainQueue(^{
                    [[BBDataBaseService sharedService] deletePayCard:oldCard];
                    [self.output currentPayCardsUserWithArray:[[BBDataBaseService sharedService] curentPayCards]];
                });
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output errorNetwork];
        }
    }];
}

@end
