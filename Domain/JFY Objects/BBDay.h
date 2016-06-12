//
//  BBDay.h
//  JustForYou
//
//  Created by Антон on 12.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

@interface BBDay : RLMObject

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBDay>
RLM_ARRAY_TYPE(BBDay)
