#import <Realm/Realm.h>

#import "BBDay.h"

@interface BBMenu : RLMObject

@property NSInteger menuId;
@property NSString *content;
@property NSInteger weight;
@property NSInteger calories;
//@property NSDate *starts_at;
@property NSInteger startsHour;
@property NSInteger startsMinute;
@property NSInteger endsHour;
@property NSInteger endsMinute;
//@property NSDate *ends_at;
@property NSInteger partDay;

@property BBDay *day;

- (instancetype)initWithJSON:(id)JSONObj;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBMenu>
RLM_ARRAY_TYPE(BBMenu)
