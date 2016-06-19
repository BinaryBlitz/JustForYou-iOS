//
//  BBOrder.h
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

@interface BBOrder : RLMObject

@property NSInteger programId;
@property NSDate *scheduledDay;
@property UIColor *colorProgram;

- (instancetype)initWithJSON:(id)JSONObj;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBOrder>
RLM_ARRAY_TYPE(BBOrder)
