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

#pragma mark - Blocks

- (void)addOrUpdateBlocksFromArray:(NSArray *)objects {
    RLMRealm *standartRealm = [RLMRealm defaultRealm];
    
    RLMResults *old = [BBBlock allObjectsInRealm:standartRealm];
    
    for (BBBlock *oldBl in old) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"blockId == %d", oldBl.blockId];
        NSArray *filteredArray = [objects filteredArrayUsingPredicate:predicate];
        if ([filteredArray count] < 1) {
            [standartRealm beginWriteTransaction];
            [standartRealm deleteObject:oldBl];
            [standartRealm commitWriteTransaction];
        }
    }
    [standartRealm beginWriteTransaction];
    [standartRealm addOrUpdateObjectsFromArray:objects];
    [standartRealm commitWriteTransaction];
    
}

- (NSArray *)blocksInRealm {
    RLMResults *res = [BBBlock allObjectsInRealm:[RLMRealm defaultRealm]];
    return [self _RLMResultsToNSArray:res];
}


#pragma mark - Programs


- (NSArray *)programsInRealmWithParentId:(NSInteger)parentId {
    BBBlock *block = [[BBBlock objectsWhere:[NSString stringWithFormat:@"blockId=%ld", (long)parentId]] firstObject];
    RLMResults *res = block.programs;
    
    return [self _RLMResultsToNSArray:res];
}


- (void)addOrUpdateProgramsFromArray:(NSArray *)objects parentId:(NSInteger)parentId {
    RLMRealm *standartRealm = [RLMRealm defaultRealm];
    BBBlock *block = [[BBBlock objectsWhere:[NSString stringWithFormat:@"blockId=%ld", (long)parentId]] firstObject];
    
    RLMResults *res = block.programs;
    [standartRealm beginWriteTransaction];
    [standartRealm deleteObjects:res];
    [standartRealm addObjects:objects];
    for (BBProgram *prog in objects) {
        
        [prog setBlock:block];
    }
    [standartRealm commitWriteTransaction];
    
}

#pragma mark - Self

- (NSArray *)_RLMResultsToNSArray:(RLMResults *)results {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:results.count];
    for (RLMObject *object in results) {
        [array addObject:object];
    }
    return array;
}


@end
