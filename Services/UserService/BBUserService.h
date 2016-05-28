//
//  BBUserService.h
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBUser.h"

@interface BBUserService : NSObject

+ (instancetype)sharedService;

- (BBUser *)currentUser;

- (void)saveCurrentUser:(BBUser *)user;

- (void)logOutUser;



- (void)saveCurrentReplacement:(NSArray *)replacement;

- (NSArray *)currentReplacementUser;

@end
