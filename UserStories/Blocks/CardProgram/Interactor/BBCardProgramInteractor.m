//
//  BBCardProgramInteractor.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBCardProgramInteractor.h"

#import "BBCardProgramInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@implementation BBCardProgramInteractor

#pragma mark - Методы BBCardProgramInteractorInput

- (NSArray *)checkDaysInDataBaseWith:(NSInteger)parentId {
    return [[BBDataBaseService sharedService] programsInRealmWithParentId:parentId];
}

- (void)daysInDataBaseWithParentId:(NSInteger)parentId {
    HQDispatchToMainQueue(^{
//        [self.output currentDaysInDataBase:[[BBDataBaseService sharedService] programsInRealmWithParentId:parentId]];
    });
}

- (void)listDaysWithParentId:(NSInteger)parentId {
    NSInteger __block parent = parentId;
    [[BBServerService sharedService] listDaysInProgramId:parentId apiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        if (response.serverError == kServerErrorSuccessfull) {
            if ([objects count] > 0) {
                HQDispatchToRealmQueue(^{
//                    [[BBDataBaseService sharedService] addOrUpdateProgramsFromArray:objects parentId:parent];
//                    [self.output daysSaveInDataBase];
                });
            }
        } else if(response.serverError == kServerErrorClient) {
            [self.output errorClient];
        } else if (response.serverError == kServerErrorServer) {
            [self.output errorServer];
        }
    }];
    
}

@end