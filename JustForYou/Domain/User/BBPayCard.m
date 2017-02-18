#import "BBPayCard.h"

@implementation BBPayCard

+ (NSString *)primaryKey {
  return @"payCardId";
}

- (instancetype)initWithJSON:(id)JSONObj {
  self = [super init];
  if (self) {
    self.payCardId = [[JSONObj valueForKey:@"id"] integerValue];
    self.holder = [JSONObj valueForKey:@"holder"];
    self.number = [JSONObj valueForKey:@"number"];
  }
  return self;
}

@end
