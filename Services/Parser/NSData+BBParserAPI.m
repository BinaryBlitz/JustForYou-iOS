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
#import "BBDay.h"

#import "BBDataBaseService.h"

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

- (NSArray *)parseArrayWithDataAndKey:(BBTypeObjectInData)key parentId:(NSInteger)parentId urlServer:(NSString *)url {
    NSMutableArray *result = [NSMutableArray array];
    id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
    if ([JSONObj isKindOfClass:[NSArray class]]) {
        for (id obj in JSONObj) {
            if (key == kTypeBlockInData) {
                BBBlock *block = [[BBBlock alloc] initWithJSON:obj andUrlServer:url];
                [result addObject:block];
            } else if (key == kTypeProgramInData) {
                BBProgram *program = [[BBProgram alloc] initWithJSON:obj andUrlServer:url];
                program.parentId = parentId;
                [result addObject:program];
            } else {
                [result addObject:obj];
            }
        }
        if (key == kTypeDayInData) {
            if ([result count] > 0) {
                [[BBDataBaseService sharedService] addOrUpdateDaysFromArray:result parentId:parentId];
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
