//
//  NSData+BBParserAPI.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"

@interface NSData (BBParserAPI)

#pragma mark - User Methods

- (NSString *)parseAuthorizateToken;
- (NSString *)parseApiToken;

- (BBUser *)parseRegisterResponseWithData;

#pragma mark - Blocks Methods

- (NSArray *)parseArrayBlocksWithData;

#pragma mark - Map Methods

- (id)parseSearchAddress;

@end
