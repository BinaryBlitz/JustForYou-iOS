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

@implementation BBReplacementInteractor

#pragma mark - Методы BBReplacementInteractorInput

- (void)currentReplacementUser {
    NSArray *replacement = [[BBUserService sharedService] currentReplacementUser];
    [self.output currentReplacementInData:replacement];
}

- (void)addInCurrentArrayReplacementNewElement:(NSString *)element {
    NSArray *replacement = [[BBUserService sharedService] currentReplacementUser];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:replacement];
    [newArray addObject:element];
    [[BBUserService sharedService] saveCurrentReplacement:newArray];
    [self.output currentReplacementUpdate];
}

- (void)deleteElementInArrayWithElement:(NSString *)element {
    NSArray *replacement = [[BBUserService sharedService] currentReplacementUser];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:replacement];
    [newArray removeObject:element];
    [[BBUserService sharedService] saveCurrentReplacement:newArray];
    [self.output elemetnDidDeleteWithNewArray:newArray];

}

@end