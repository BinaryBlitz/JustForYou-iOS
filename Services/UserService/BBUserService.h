//
//  BBUserService.h
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBUser.h"
#import "BBAddress.h"
#import "BBOrderProgram.h"

@interface BBUserService : NSObject

+ (instancetype)sharedService;

- (NSString *)tokenUser;
- (void)saveUserApiToken:(NSString *)apiToken;

- (BBUser *)currentUser;
- (void)saveCurrentUser:(BBUser *)user;
- (void)logOutUser;

- (void)addOrderProgramToUserWithProgramId:(NSInteger)programId countDays:(NSInteger)countDays;
- (void)updateOrderProgramWithOrderProgram:(BBOrderProgram *)orderProgram;
- (void)deleteInOrdersUserOrderProgram:(BBOrderProgram *)order;
- (void)deleteAllOrderProgramInUser;
- (BOOL)addAddressToUserWithAddress:(BBAddress *)address;
- (void)deleteAddressOnUser:(BBAddress *)address;

- (void)saveCurrentReplacement:(NSArray *)replacement;

- (NSArray *)currentReplacementUser;

@end
