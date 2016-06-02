//
//  NSData+BBParserAPI.m
//  JustForYou
//
//  Created by Антон on 21.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "NSData+BBParserAPI.h"

@implementation NSData (BBParserAPI)

#pragma mark - User Methods

- (NSString *)parseAuthorizateToken {
    return [[NSJSONSerialization JSONObjectWithData:self options:0 error:nil] objectForKey:@"token"];
}

#warning see this method for error server

- (BBUser *)parseRegisterResponseWithData {
    id JSONObj = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
    BBUser *user = nil;
    if ([JSONObj count] > 1) {
        user = [[BBUser alloc] initWithJSON:JSONObj];
    }
    return user;
}


#pragma mark - Map Methods

- (id)parseSearchAddress {
    return [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];;
}

@end
