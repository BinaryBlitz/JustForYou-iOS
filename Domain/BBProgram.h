//
//  BBProgram.h
//  JustForYou
//
//  Created by Антон on 14.05.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

@interface BBProgram : RLMObject



@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBProgram>
RLM_ARRAY_TYPE(BBProgram)