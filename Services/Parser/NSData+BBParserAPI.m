//
//  NSData+BBParserAPI.m
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "NSData+BBParserAPI.h"

#import "BBBlock.h"
#import "BBProgram.h"

@implementation NSData (BBParserAPI)

#pragma mark - User Methods

- (NSString *)parseAuthorizateToken {
    return [[NSJSONSerialization JSONObjectWithData:self options:0 error:nil] objectForKey:@"token"];
}

- (NSString *)parseApiToken {
    return [[NSJSONSerialization JSONObjectWithData:self options:0 error:nil] objectForKey:@"api_token"];
}

- (BBUser *)parseRegisterResponseWithData {
    id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
    BBUser *user = nil;
    if ([JSONObj count] > 1) {
        user = [[BBUser alloc] initWithJSON:JSONObj];
    }
    return user;
}


#pragma mark - Blocks And Program Methods

- (NSArray *)parseArrayWithDataAndKey:(BBTypeObjectInData)key parentId:(NSInteger)parentId {
    NSMutableArray *result = [NSMutableArray array];
    id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
    if ([JSONObj isKindOfClass:[NSArray class]]) {
        for (id blockObj in JSONObj) {
            if (key == kTypeBlockInData) {
                BBBlock *block = [[BBBlock alloc] initWithJSON:blockObj];
                [result addObject:block];
            } else {
                BBProgram *program = [[BBProgram alloc] initWithJSON:blockObj];
                program.parentId = parentId;
                [result addObject:program];
            }
        }
    }
    return result;
}

#pragma mark - Map Methods

- (id)parseSearchAddress {
    return [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];;
}

@end
