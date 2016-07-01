//
//  BBReplaceProgramInteractor.m
//  JustForYou
//
//  Created by tercteberc on 30/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplaceProgramInteractor.h"

#import "BBReplaceProgramInteractorOutput.h"

#import "BBServerService.h"
#import "BBUserService.h"

@implementation BBReplaceProgramInteractor

#pragma mark - Методы BBReplaceProgramInteractorInput

- (void)listAllPrograms {
    [[BBServerService sharedService] listAllProgramsWithApiToken:[[BBUserService sharedService] tokenUser]
                                                      completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
                                                          if (response.kConnectionServer == kSuccessfullyConnection) {
                                                              if (response.serverError == kServerErrorSuccessfull) {
                                                                  [self.output allProgramsWithArray:objects];
                                                              } else {
                                                                  [self.output errorServer];
                                                              }
                                                          } else {
                                                              [self.output errorNetwork];
                                                          }
    }];
}

- (void)createReplaceWithPurchase:(BBPurchases *)purchase program:(BBProgram *)program {
    [[BBServerService sharedService] createExchangesWithApiToken:[[BBUserService sharedService] tokenUser] purchase:[NSString stringWithFormat:@"%ld", (long)purchase.purchasesId] program:[NSNumber numberWithInteger:program.programId] completion:^(BBServerResponse *response, BBExchange *exchange, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.serverError == kServerErrorSuccessfull) {
                [self.output exchangeDidCreate:exchange];
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output errorNetwork];
        }
    }];
}


- (void)payWithExchange:(BBExchange *)exchange {
    [[BBServerService sharedService] payExchangeWithApiToken:[[BBUserService sharedService] tokenUser] exchange:exchange completion:^(BBServerResponse *response, NSData *data, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            id Obj = [NSJSONSerialization
                      JSONObjectWithData:data
                      options:0
                      error:nil];
            NSInteger payId = [[Obj valueForKey:@"id"] integerValue];
            NSString *payUrl = [Obj valueForKey:@"payment_url"];
            [self.output exchangeWithPayId:payId payURL:payUrl];
        } else {
            [self.output errorNetwork];
        }
    }];
}

- (void)payOnServerWithPayCard:(BBPayCard *)card paiId:(NSInteger)paiId {
    [[BBServerService sharedService] createPaymentsWithPayCard:card.payCardId orderId:paiId apiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, BOOL paid, NSError *error) {
        if (paid) {
            [self.output paymentSuccessfull];
        } else {
            [self.output paymentError];
        }
    }];
}

@end