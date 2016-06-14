//
//  BBCardProgramInteractorInput.h
//  JustForYou
//
//  Created by tercteberc on 07/04/2016.
//  Copyright 2016 Binary Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCardProgramInteractorInput <NSObject>

- (NSArray *)checkDaysInDataBaseWith:(NSInteger)parentId;

- (void)programInDataBaseWithParentId:(NSInteger)parentId;

- (void)listDaysWithParentId:(NSInteger)parentId;


- (void)addInOrdersUserOrderWithProgramId:(NSInteger)programId countDay:(NSInteger)countDay;

@end
