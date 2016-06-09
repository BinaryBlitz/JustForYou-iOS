//
//  BBDataBaseService.m
//  JustForYou
//
//  Created by Антон on 08.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBDataBaseService.h"

@implementation BBDataBaseService

+ (instancetype) sharedService {
    static BBDataBaseService* service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[BBDataBaseService alloc] init];
    });
    return service;
}

- (void)addOrUpdateObjectsFromArray:(NSArray *)objects {
    RLMRealm *standartRealm = [RLMRealm defaultRealm];
    
    [standartRealm beginWriteTransaction];
    RLMResults *old = [BBBlock allObjectsInRealm:standartRealm];
    [standartRealm deleteObjects:old];
    [standartRealm addOrUpdateObjectsFromArray:objects];
    [standartRealm commitWriteTransaction];
}

- (NSArray *)blocksInRealm {
    RLMResults *res = [BBBlock allObjectsInRealm:[RLMRealm defaultRealm]];
    return [self _RLMResultsToNSArray:res];
}

- (NSArray *)_RLMResultsToNSArray:(RLMResults *)results {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.count];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    return array;
}


@end
