//
//  BBPayCard.h
//  JustForYou
//
//  Created by Антон on 19.06.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import <Realm/Realm.h>

@interface BBPayCard : RLMObject

@property NSInteger payCardId;
@property NSString *holder;
@property NSString *number;

- (instancetype)initWithJSON:(id)JSONObj;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBPayCard>
RLM_ARRAY_TYPE(BBPayCard)
