//
//  BBDataBaseService.h
//  JustForYou
//
//  Created by Антон on 08.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

#import "BBBlock.h"
#import "BBProgram.h"
#import "BBDay.h"
#import "BBOrder.h"

@interface BBDataBaseService : NSObject

+ (instancetype) sharedService;

#pragma mark - Blocks

- (void)addOrUpdateBlocksFromArray:(NSArray *)objects;
- (NSArray *)blocksInRealm;

#pragma mark - Programs

- (NSArray *)programsInRealmWithParentId:(NSInteger)parentId;
- (BBProgram *)programInRealmWithProgramId:(NSInteger)programId;
- (void)addOrUpdateProgramsFromArray:(NSArray *)objects parentId:(NSInteger)parentId;

#pragma mark - Days

- (NSArray *)daysInRealmWithParentId:(NSInteger)parentId;
- (void)addOrUpdateDaysFromArray:(NSArray *)objects parentId:(NSInteger)parentId;

#pragma mark - Orders

- (void)addOrUpdateOrdersFromArray:(NSArray *)objects;
- (NSArray *)ordersInRealm;

@end
