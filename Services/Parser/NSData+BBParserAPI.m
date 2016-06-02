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


#pragma mark - Map Methods

- (id)parseSearchAddress {
    return [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];;
}

@end
