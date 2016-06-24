//
//  BBListMyProgInteractor.m
//  JustForYou
//
//  Created by tercteberc on 24/06/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import "BBListMyProgInteractor.h"

#import "BBListMyProgInteractorOutput.h"

#import "BBUserService.h"

@implementation BBListMyProgInteractor

#pragma mark - Методы BBListMyProgInteractorInput

- (void)addInOrdersUserOrderWithProgramId:(NSInteger)programId countDay:(NSInteger)countDay {
    [[BBUserService sharedService] addOrderProgramToUserWithProgramId:programId countDays:countDay];
}

@end