//
//  BBProgram.h
//  JustForYou
//
//  Created by Антон on 11.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

#import "BBBlock.h"

static NSString * const BBProgramUnitDay = @"day";
static NSString * const BBProgramUnitPiece = @"piece";

@interface BBProgram : RLMObject

@property NSInteger programId;
@property NSInteger parentId;
@property NSString *name;
@property NSString *descript;
@property NSString *shortDescript;
@property NSInteger threshold;
@property NSInteger primaryPrice;
@property NSInteger secondaryPrice;
@property NSString *firstPrescription;
@property NSString *secondPrescription;
@property NSString *thirdPrescription;
@property NSString *previewImage;
@property BOOL individualPrice;
@property NSString *unit;

@property BBBlock *block;
@property (readonly) RLMLinkingObjects *days;

- (instancetype)initWithJSON:(id)JSONObj;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBProgram>
RLM_ARRAY_TYPE(BBProgram)
