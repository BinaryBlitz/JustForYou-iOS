//
//  NSData+BBParserAPI.h
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBUser.h"

typedef enum : NSUInteger {
    kTypeBlockInData,
    kTypeProgramInData
}BBTypeObjectInData;


@interface NSData (BBParserAPI)

#pragma mark - User Methods

- (NSString *)parseAuthorizateToken;
- (NSString *)parseApiToken;

- (BBUser *)parseRegisterResponseWithData;

#pragma mark - Blocks And Program Methods

- (NSArray *)parseArrayWithDataAndKey:(BBTypeObjectInData)key;

#pragma mark - Map Methods

- (id)parseSearchAddress;

@end
