//
//  BBBlock.h
//  JustForYou
//
//  Created by Антон on 08.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

#import "BBProgram.h"

@interface BBBlock : RLMObject

@property NSInteger blockId;
@property NSString *name;
@property NSString *image;

@property RLMArray <BBProgram *><BBProgram> *programs;


- (instancetype)initWithJSON:(id)JSONObj;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBBlock>
RLM_ARRAY_TYPE(BBBlock)