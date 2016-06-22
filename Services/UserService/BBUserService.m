//
//  BBUserService.m
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBUserService.h"

static NSString *kApiTokenUser = @"kApiTokenUser";
static NSString *kCurrentUser = @"kCurrentUser";

static NSString *kUserReplacement = @"kUserReplacement";

@implementation BBUserService

+ (instancetype)sharedService {
    static BBUserService* userService = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        userService = [[BBUserService alloc]init];
    });
    return userService;
}

#pragma mark - Methods For User

- (NSString *)tokenUser {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kApiTokenUser];
}

- (void)saveUserApiToken:(NSString *)apiToken {
    [[NSUserDefaults standardUserDefaults] setObject:apiToken forKey:kApiTokenUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BBUser *)currentUser {
    NSData* userData = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUser];
    if (userData) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    }
    return nil;
}

- (void)saveCurrentUser:(BBUser *)user {
    NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:kCurrentUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)updateUserWithUser:(BBUser *)user {
    BBUser *oldUser = [self currentUser];
    user.ordersProgramArray = oldUser.ordersProgramArray;
    user.addressArray = oldUser.addressArray;
    [self saveCurrentUser:user];
}

- (void)logOutUser {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUser];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kApiTokenUser];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserReplacement];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)addOrderProgramToUserWithProgramId:(NSInteger)programId countDays:(NSInteger)countDays {
    BBUser *user = [self currentUser];
    NSMutableArray *array = [NSMutableArray arrayWithArray:user.ordersProgramArray];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"programId==%d", programId];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    if ([filteredArray count] < 1) {
        BBOrderProgram *orderPro = [[BBOrderProgram alloc] init];
        orderPro.programId = programId;
        orderPro.countDays = countDays;
        [array addObject:orderPro];
    } else {
        for (BBOrderProgram *ordProg in filteredArray) {
            ordProg.countDays = ordProg.countDays + countDays;
            [array removeObject:ordProg];
            [array addObject:ordProg];
        }
    }
    if (user.ordersProgramArray == nil) {
        user.ordersProgramArray = [NSArray array];
    }
    user.ordersProgramArray = array;
    [self saveCurrentUser:user];
}

- (void)deleteInOrdersUserOrderProgram:(BBOrderProgram *)order {
    BBUser *user = [self currentUser];
    NSMutableArray *array = [NSMutableArray arrayWithArray:user.ordersProgramArray];
    for (BBOrderProgram *oldProg in user.ordersProgramArray) {
        if (oldProg.programId == order.programId) {
            [array removeObject:oldProg];
        }
    }
    user.ordersProgramArray = array;
    [self saveCurrentUser:user];
}

- (void)updateOrderProgramWithOrderProgram:(BBOrderProgram *)orderProgram {
    BBUser *user = [self currentUser];
    NSMutableArray *array = [NSMutableArray arrayWithArray:user.ordersProgramArray];
    for (int i = 0; i < [array count]; i++) {
        BBOrderProgram *ord = [array objectAtIndex:i];
        if (ord.programId == orderProgram.programId) {
            ord.countDays = orderProgram.countDays;
            [array replaceObjectAtIndex:i withObject:ord];
        }
    }
    user.ordersProgramArray = array;
    [self saveCurrentUser:user];
}

- (void)deleteAllOrderProgramInUser {
    BBUser *user = [self currentUser];
    user.ordersProgramArray = [NSArray array];
    [self saveCurrentUser:user];
}

- (void)addAddressUserFromArray:(NSArray *)objects {
    BBUser *user = [self currentUser];
    user.addressArray = [NSArray arrayWithArray:objects];
    [self saveCurrentUser:user];
}

- (BOOL)addAddressToUserWithAddress:(BBAddress *)address {
    BBUser *user = [self currentUser];
    NSMutableArray *array = [NSMutableArray arrayWithArray:user.addressArray];

    [array addObject:address];
    if (user.addressArray == nil) {
        user.addressArray = [NSArray array];
    }
    user.addressArray = array;
    [self saveCurrentUser:user];
    return YES;
}

- (void)deleteAddressOnUser:(BBAddress *)address {
    BBUser *user = [self currentUser];
    NSMutableArray *array = [NSMutableArray arrayWithArray:user.addressArray];
    for (int i = 0; i < [user.addressArray count]; i++) {
        BBAddress *removeAd = [user.addressArray objectAtIndex:i];
        if (removeAd.addressId == address.addressId) {
            [array removeObjectAtIndex:i];
        }
    }
    user.addressArray = array;
    [self saveCurrentUser:user];
}

#pragma mark - Other Methods

- (void)saveCurrentReplacement:(NSArray *)replacement {
    NSData* replace = [NSKeyedArchiver archivedDataWithRootObject:replacement];
    [[NSUserDefaults standardUserDefaults] setObject:replace forKey:kUserReplacement];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)currentReplacementUser {
    NSData* replace = [[NSUserDefaults standardUserDefaults] objectForKey:kUserReplacement];
    if (replace) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:replace];
    }
    return  nil;
}

- (void)updateReplasementWithArray:(NSArray *)replacement {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserReplacement];
    [self saveCurrentReplacement:replacement];
}

- (void)updateReplasementWithProduct:(BBReplacementProduct *)product {
    NSArray *replacement = [self currentReplacementUser];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:replacement];
    [newArray addObject:product];
    [self saveCurrentReplacement:newArray];
}
@end
