//
//  BBProgram.h
//  JustForYou
//
//  Created by Антон on 14.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

@interface BBProgram : RLMObject

@property NSInteger programId;
@property NSInteger parentId;
@property NSString *name;
@property NSString *descript;
@property NSInteger threshold;
@property NSInteger primaryPrice;
@property NSInteger secondaryPrice;
@property NSString *previewImage;

- (instancetype)initWithJSON:(id)JSONObj;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBProgram>
RLM_ARRAY_TYPE(BBProgram)