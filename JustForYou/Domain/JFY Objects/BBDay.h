#import <Realm/Realm.h>

#import "BBProgram.h"

@interface BBDay : RLMObject

@property NSInteger dayId;
@property NSInteger parentId;
@property NSInteger position;
@property NSInteger calories;
@property NSInteger morningMenu;
@property NSInteger dayMenu;
@property NSInteger eveningMenu;

@property (readonly) RLMLinkingObjects *items;

@property BBProgram *program;

- (instancetype)initWithJSON:(id)JSONObj;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<BBDay>
RLM_ARRAY_TYPE(BBDay)
