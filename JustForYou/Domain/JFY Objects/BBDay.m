#import "BBDay.h"

#import "BBMenu.h"

@implementation BBDay

+ (NSDictionary *)linkingObjectsProperties {
  return @{
      @"items": [RLMPropertyDescriptor descriptorWithClass:BBMenu.class propertyName:@"day"],
  };
}

+ (NSArray *)ignoredProperties {
  return @[@"parentId"];
}

- (instancetype)initWithJSON:(id)JSONObj {
  self = [super init];
  if (self) {
    self.dayId = [[JSONObj valueForKey:@"id"] integerValue];
    self.position = [[JSONObj valueForKey:@"position"] integerValue];
    self.calories = [[JSONObj valueForKey:@"calories"] integerValue];
//        [self _setMenuToDayWithJSON:[JSONObj objectForKey:@"items"] withDay:self];
  }
  return self;
}

@end
