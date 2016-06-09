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

- (void)addOrUpdateObjectsFromArray:(NSArray *)objects;

- (NSArray *)blocksInRealm;

@end
