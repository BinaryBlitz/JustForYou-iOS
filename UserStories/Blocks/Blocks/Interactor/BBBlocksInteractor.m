//
//  BBBlocksInteractor.m
//  JustForYou
//
//  Created by tercteberc on 28/03/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBBlocksInteractor.h"

#import "BBBlocksInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@implementation BBBlocksInteractor

#pragma mark - Методы BBBlocksInteractorInput

- (BOOL)checkObjectsInDataBase {
    return [[RLMRealm defaultRealm] isEmpty];
}

- (void)blocksInDataBase {
    HQDispatchToMainQueue(^{
        [self.output currentBlocksInDataBase:[[BBDataBaseService sharedService] blocksInRealm]];
    });
}

- (void)listBlocksWithKey:(BBKeyStateData)key {
    [[BBServerService sharedService] listBlocksWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        if (response.serverError == kServerErrorSuccessfull) {
            if ([objects count] > 0) {
                [[BBDataBaseService sharedService] addOrUpdateBlocksFromArray:objects];
                [self.output blocksSaveInDataBase];
            }
        } else if(response.serverError == kServerErrorClient) {
            [self.output errorClient];
        } else if (response.serverError == kServerErrorServer) {
            [self.output errorServer];
        }
    }];
}


- (void)checkBasket {
    BBUser *user = [[BBUserService sharedService] currentUser];
    [self.output currentProgramsInBasket:user.ordersProgramArray];
}

@end