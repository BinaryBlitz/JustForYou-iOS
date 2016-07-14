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

- (BBProgram *)programInRealmWithProgramId:(NSInteger)programId {
    return [[BBProgram objectsWhere:[NSString stringWithFormat:@"programId=%ld", (long)programId]] lastObject];
}

- (void)addOrUpdateProgramsFromArray:(NSArray *)objects parentId:(NSInteger)parentId {
    RLMRealm *standartRealm = [RLMRealm defaultRealm];
    BBBlock *block = [[BBBlock objectsWhere:[NSString stringWithFormat:@"blockId=%ld", (long)parentId]] firstObject];
    
    RLMResults *res = block.programs;
    for (BBProgram *oldProg in res) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"programId == %d", oldProg.programId];
        NSArray *filteredArray = [objects filteredArrayUsingPredicate:predicate];
        if ([filteredArray count] < 1) {
            [standartRealm beginWriteTransaction];
            RLMResults *res = oldProg.days;
            for (BBDay *day in res) {
                RLMResults *res2 = day.items;
                for (BBMenu *menu in res2) {
                    [standartRealm deleteObject:menu];
                }
                [standartRealm deleteObject:day];
            }
            [standartRealm deleteObject:oldProg];
            [standartRealm commitWriteTransaction];
        }
    }
    
    [standartRealm beginWriteTransaction];
//    [standartRealm deleteObjects:res];
    [standartRealm addOrUpdateObjectsFromArray:objects];
    for (BBProgram *prog in objects) {
        [prog setBlock:block];
    }
    [standartRealm commitWriteTransaction];
    
}

#pragma mark - Days

- (NSArray *)daysInRealmWithParentId:(NSInteger)parentId {
    BBProgram *program = [[BBProgram objectsWhere:[NSString stringWithFormat:@"programId=%ld", (long)parentId]] firstObject];
    RLMResults *res = program.days;
    
    return [self _RLMResultsToNSArray:res];
}

- (void)addOrUpdateDaysFromArray:(NSArray *)objects parentId:(NSInteger)parentId {
    RLMRealm *standartRealm = [RLMRealm defaultRealm];
    BBProgram *program = [[BBProgram objectsWhere:[NSString stringWithFormat:@"programId=%ld", (long)parentId]] firstObject];
    RLMResults *res = program.days;
    [standartRealm beginWriteTransaction];
    for (BBDay *days in res) {
        RLMResults *res2 = days.items;
        for (BBMenu *menu in res2) {
            [standartRealm deleteObject:menu];
        }
        [standartRealm deleteObject:days];
    }
    [standartRealm commitWriteTransaction];
    
    NSMutableArray *resultsDay = [NSMutableArray array];
    NSMutableArray *resultsMenu = [NSMutableArray array];
    for (id obj in objects) {
        BBDay *day = [[BBDay alloc] initWithJSON:obj];
        day.parentId = parentId;
        day.morningMenu = 0;
        day.dayMenu = 0;
        day.eveningMenu = 0;
        [resultsMenu addObject:[self _setMenuToDayWithJSON:[obj objectForKey:@"items"] withDay:day]];
        [resultsDay addObject:day];
    }
    
    
    [standartRealm beginWriteTransaction];
//    [standartRealm deleteObjects:res];
    for (int i = 0; i < [resultsDay count]; i++) {
        BBDay *day = [resultsDay objectAtIndex:i];
        for (BBMenu *menu in [resultsMenu objectAtIndex:i]) {
            [menu setDay:day];
            [standartRealm addObject:menu];
        }
        [day setProgram:program];
        [standartRealm addObject:day];
//        [results addObject:day];
    }
    [standartRealm commitWriteTransaction];
    
}


- (NSArray *)_setMenuToDayWithJSON:(id)JSONObj withDay:(BBDay *)day {
    NSMutableArray *array = [NSMutableArray array];
    if (JSONObj && [JSONObj isKindOfClass:[NSArray class]]) {
        for (id obj in JSONObj) {
            BBMenu *menu = [[BBMenu alloc] initWithJSON:obj];
            [self _setPartDayForMenu:menu day:day];
            [array addObject:menu];
        }
    }
    return array;
}


- (void)_setPartDayForMenu:(BBMenu *)menu day:(BBDay *)day {
    if ((menu.startsHour >= 6) && (menu.endsHour <= 12)) {
        menu.partDay = kMorningPartOfDay;
        day.morningMenu++;
    }
    if ((menu.startsHour >= 12) && (menu.endsHour <= 18)) {
        menu.partDay = kDayPartOfDay;
        day.dayMenu++;
    }
    if ((menu.startsHour >= 18) && ((menu.endsHour <= 22) && (menu.endsMinute <= 59))) {
        menu.partDay = kEveningPartOfDay;
        day.eveningMenu++;
    }
}


#pragma mark - Orders

- (void)addOrUpdateOrdersFromArray:(NSArray *)objects callback:(CallBack)callback {
    RLMRealm *standartRealm = [RLMRealm defaultRealm];
    RLMResults *old = [BBOrder allObjectsInRealm:standartRealm];
    
    [standartRealm transactionWithBlock:^{
        [standartRealm deleteObjects:old];
        [standartRealm addOrUpdateObjectsFromArray:objects];
        callback();
    }];
//    [standartRealm beginWriteTransaction];
//    
//    [standartRealm commitWriteTransaction];
//    [standartRealm beginWriteTransaction];
//    
//    [standartRealm commitWriteTransaction];
}

- (void)deleteOrderForOrderId:(NSInteger)orderId callback:(CallBack)callback {
    RLMRealm *standartRealm = [RLMRealm defaultRealm];
    BBOrder *order = [BBOrder objectsWhere:[NSString stringWithFormat:@"orderId=%ld", (long)orderId]].firstObject;
    
    [standartRealm transactionWithBlock:^{
        [standartRealm deleteObject:order];
        callback();
    }];
//    [standartRealm beginWriteTransaction];
//    [standartRealm commitWriteTransaction];
}

- (NSArray *)ordersInRealm {
    RLMResults *res = [BBOrder allObjectsInRealm:[RLMRealm defaultRealm]];
    return [self _RLMResultsToNSArray:res];
}


#pragma mark - PayCard

- (NSArray *)curentPayCards {
    RLMResults *res = [BBPayCard allObjectsInRealm:[RLMRealm defaultRealm]];
    return [self _RLMResultsToNSArray:res];
}

- (void)addOrUpdatePayCardsUserWithArray:(NSArray *)objects {
    RLMRealm *standartRealm = [RLMRealm defaultRealm];
    
    RLMResults *old = [BBPayCard allObjectsInRealm:standartRealm];
    
    for (BBPayCard *oldPayCard in old) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"payCardId == %d", oldPayCard.payCardId];
        NSArray *filteredArray = [objects filteredArrayUsingPredicate:predicate];
        if ([filteredArray count] < 1) {
            [standartRealm beginWriteTransaction];
            [standartRealm deleteObject:oldPayCard];
            [standartRealm commitWriteTransaction];
        }
    }
    [standartRealm beginWriteTransaction];
    [standartRealm addOrUpdateObjectsFromArray:objects];
    [standartRealm commitWriteTransaction];
}

- (void)deleteAllPayCardsUser {
    RLMResults *res = [BBPayCard allObjectsInRealm:[RLMRealm defaultRealm]];
    [[RLMRealm defaultRealm] beginWriteTransaction];
    [[RLMRealm defaultRealm] deleteObjects:res];
    [[RLMRealm defaultRealm] commitWriteTransaction];
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
