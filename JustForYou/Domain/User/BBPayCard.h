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
