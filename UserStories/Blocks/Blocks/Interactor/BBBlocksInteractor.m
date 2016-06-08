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

@implementation BBBlocksInteractor

#pragma mark - Методы BBBlocksInteractorInput

- (void)getList {
    [[BBServerService sharedService] listBlocksWithApiToken:[[BBUserService sharedService] tokenUser] completion:^(BBServerResponse *response, NSArray *objects, NSError *error) {
        
    }];
}

@end