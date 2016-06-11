//
//  BBProgramsInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

#import "BBProgram.h"

@protocol BBProgramsInteractorInput <NSObject>

- (NSArray *)checkProgramsInDataBaseWith:(NSInteger)parentId;

- (void)programsInDataBaseWithParentId:(NSInteger)parentId;

- (void)listProgramsWithParentId:(NSInteger)parentId;

@end