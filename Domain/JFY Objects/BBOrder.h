//
//  BBOrder.h
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

@interface BBOrder : RLMObject

@property NSInteger orderId;
@property NSDate *scheduledDay;
@property NSString *commentOrder;
@property float red;
@property float green;
@property float blue;
@property NSString *nameProgram;
@property NSString *nameBlock;
@property NSString *address;


- (instancetype)initWithJSON:(id)JSONObj;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBOrder>
RLM_ARRAY_TYPE(BBOrder)
