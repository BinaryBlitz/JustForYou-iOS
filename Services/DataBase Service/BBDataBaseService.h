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

@interface BBDataBaseService : NSObject

+ (instancetype) sharedService;

#pragma mark - Blocks

- (void)addOrUpdateBlocksFromArray:(NSArray *)objects;
- (NSArray *)blocksInRealm;

#pragma mark - Programs

- (NSArray *)programsInRealmWithParentId:(NSInteger)parentId;
- (void)addOrUpdateProgramsFromArray:(NSArray *)objects parentId:(NSInteger)parentId;

@end
