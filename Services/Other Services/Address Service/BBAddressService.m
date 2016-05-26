//
//  BBAddressService.m
//  JustForYou
//
//  Created by Антон on 26.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBAddressService.h"

@implementation BBAddressService

#warning Check this code

+ (BBAddress *)addressFromAddress:(LMAddress *)addr {
    NSString *route = [self component:@"route" inArray:addr.lines ofType:@"short_name"];
    NSString *streetName = nil;
    
    if (route && addr.thoroughfare) {
        streetName = [NSString stringWithFormat:@"%@, %@", route, addr.thoroughfare];
    } else if (route) {
        streetName = [NSString stringWithFormat:@"%@", route];
    } else {
        return nil;
    }
    
    BBAddress *address = [[BBAddress alloc] initWithCoordinate:addr.coordinate country:addr.country city:addr.locality address:streetName];
    
    return address;
}


+ (NSString *)component:(NSString *)component inArray:(NSArray *)array ofType:(NSString *)type {
    
    NSInteger index = [array indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return [(NSString *)([[obj objectForKey:@"types"] firstObject]) isEqualToString:component];
    }];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    if (index >= array.count) {
        return nil;
    }
    
    return [[array objectAtIndex:index] valueForKey:type];
}

@end
