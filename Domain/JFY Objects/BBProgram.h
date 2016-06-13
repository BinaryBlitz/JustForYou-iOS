//
//  BBProgram.h
//  JustForYou
//
//  Created by Антон on 11.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

#import "BBBlock.h"

@interface BBProgram : RLMObject

@property NSInteger programId;
@property NSInteger parentId;
@property NSString *name;
@property NSString *descript;
@property NSInteger threshold;
@property NSInteger primaryPrice;
@property NSInteger secondaryPrice;
@property NSString *firstPrescription;
@property NSString *secondPrescription;
@property NSString *thirdPrescription;
@property NSString *previewImage;

@property BBBlock *block;
@property (readonly) RLMLinkingObjects *days;

- (instancetype)initWithJSON:(id)JSONObj andUrlServer:(NSString *)url;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBProgram>
RLM_ARRAY_TYPE(BBProgram)
