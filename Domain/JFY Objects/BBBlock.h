//
//  BBBlock.h
//  JustForYou
//
//  Created by Антон on 09.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

@interface BBBlock : RLMObject

@property NSInteger blockId;
@property NSString *name;
@property NSString *image;
@property NSInteger programs_count;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;

//@property RLMArray<BBProgram> *programs;

@property (readonly) RLMLinkingObjects *programs;

- (instancetype)initWithJSON:(id)JSONObj;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBBlock>
RLM_ARRAY_TYPE(BBBlock)
