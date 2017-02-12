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
#import "BBReplacementCategory.h"

@interface BBUserService : NSObject

+ (instancetype)sharedService;

- (NSString *)tokenUser;
- (void)saveUserApiToken:(NSString *)apiToken;

- (BBUser *)currentUser;
- (void)saveCurrentUser:(BBUser *)user;
- (void)updateUserWithUser:(BBUser *)user;
- (NSInteger)userBonuses;
- (BOOL)enableBonuses;
- (void)setEnableBonuses:(BOOL)state;
- (void)logOutUser;

- (void)addOrderProgramToUserWithProgramId:(NSInteger)programId countDays:(NSInteger)countDays;
- (void)updateOrderProgramWithOrderProgram:(BBOrderProgram *)orderProgram;
- (void)deleteInOrdersUserOrderProgram:(BBOrderProgram *)order;
- (void)deleteAllOrderProgramInUser;

- (void)addAddressUserFromArray:(NSArray *)objects;
- (BOOL)addAddressToUserWithAddress:(BBAddress *)address;
- (void)deleteAddressOnUser:(BBAddress *)address;

- (void)saveCurrentReplacement:(NSArray *)replacement;

- (NSArray *)currentReplacementUser;
- (void)updateReplasementWithArray:(NSArray *)replacement;
- (void)updateReplasementWithProduct:(BBReplacementProduct *)product;

@end
