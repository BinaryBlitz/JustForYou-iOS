//
//  BBReplacementInteractor.m
//  JustForYou
//
//  Created by tercteberc on 28/05/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBReplacementInteractor.h"

#import "BBReplacementInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"

@implementation BBReplacementInteractor

#pragma mark - Методы BBReplacementInteractorInput

- (void)currentReplacementUser {
    NSArray *replacement = [[BBUserService sharedService] currentReplacementUser];
    [self.output currentReplacementInData:replacement];
}

- (void)addInCurrentArrayReplacementNewElement:(BBReplacementProduct *)element {
    __block BBReplacementProduct *product = element;
    [[BBServerService sharedService] createReplacementWithApiToken:[[BBUserService sharedService] tokenUser] productId:element.productId completion:^(BBServerResponse *response, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.serverError == kServerErrorSuccessfull) {
                [[BBUserService sharedService] updateReplasementWithProduct:product];
                [self.output currentReplacementUpdate];
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output errorNetwork];
        }
    }];
    }

- (void)deleteElementInArrayWithElement:(BBReplacementProduct *)element {
    NSArray *replacement = [[BBUserService sharedService] currentReplacementUser];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:replacement];
    for (BBReplacementProduct *old in replacement) {
        if (old.productId == element.productId) {
            [newArray removeObject:old];
        }
    }
    [[BBUserService sharedService] saveCurrentReplacement:newArray];
    [self.output elemetnDidDeleteWithNewArray:newArray];

}

- (void)listReplacementOnServer {
    [[BBServerService sharedService] listProductsForReplasementWithToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        if (response.kConnectionServer == kSuccessfullyConnection) {
            if (response.serverError == kServerErrorSuccessfull) {
                [self.output replacementCategoryInArray:objects];
            } else {
                [self.output errorServer];
            }
        } else {
            [self.output errorNetwork];
        }
    }];
}

@end