

#import "BBCalendarService.h"

@implementation BBStock

- (instancetype)initWithJSON:(id)JSONObj {
  self = [super init];
  if (self) {
    self.stockId = [[JSONObj valueForKey:@"id"] integerValue];
    self.name = [JSONObj valueForKey:@"name"];
    self.descript = [JSONObj valueForKey:@"description"];
    self.date = [[BBCalendarService sharedService] dateForString:[JSONObj valueForKey:@"created_at"]];
  }
  return self;
}

@end
