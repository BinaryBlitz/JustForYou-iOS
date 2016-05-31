//
//  BBUserService.m
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBUserService.h"


static NSString *kApiTokenUser = @"kApiToken";
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

- (void)saveApiTokenUser:(NSString *)apiToken {
    [[NSUserDefaults standardUserDefaults] setObject:apiToken forKey:kApiTokenUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)tokenUser {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kApiTokenUser];
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

- (void)logOutUser {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Other Methods

- (void)saveCurrentReplacement:(NSArray *)replacement {
    [[NSUserDefaults standardUserDefaults] setObject:replacement forKey:kUserReplacement];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)currentReplacementUser {
    return  [[NSUserDefaults standardUserDefaults] objectForKey:kUserReplacement];
}

@end
