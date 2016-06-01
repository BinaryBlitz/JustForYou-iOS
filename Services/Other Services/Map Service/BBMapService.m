//
//  BBMapService.m
//  JustForYou
//
//  Created by Антон on 01.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBMapService.h"

@implementation BBMapService

+ (instancetype) sharedService {
    static BBMapService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[BBMapService alloc] init];
    });
    return service;
}



@end
