//
//  BBProgramsInteractor.m
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBProgramsInteractor.h"

#import "BBProgramsInteractorOutput.h"

#import "BBUserService.h"
#import "BBServerService.h"
#import "BBDataBaseService.h"

@implementation BBProgramsInteractor

#pragma mark - Методы BBProgramsInteractorInput

- (NSArray *)checkProgramsInDataBaseWith:(NSInteger)parentId {
    return [[BBDataBaseService sharedService] programsInRealmWithParentId:parentId];
}

- (void)programsInDataBaseWithParentId:(NSInteger)parentId {
    HQDispatchToMainQueue(^{
        [self.output currentProgramsInDataBase:[[BBDataBaseService sharedService] programsInRealmWithParentId:parentId]];
    });
}

- (void)listProgramsWithParentId:(NSInteger)parentId {
    NSInteger __block parent = parentId;
    [[BBServerService sharedService] listProgramsWithApiToken:[[BBUserService sharedService] tokenUser] blockId:parentId completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        if (response.serverError == kServerErrorSuccessfull) {
            if ([objects count] > 0) {
                HQDispatchToRealmQueue(^{
                    [[BBDataBaseService sharedService] addOrUpdateProgramsFromArray:objects parentId:parent];
                    [self.output programsSaveInDataBase];
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