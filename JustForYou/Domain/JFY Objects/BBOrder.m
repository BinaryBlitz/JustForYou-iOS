

#import "BBCalendarService.h"

@implementation BBOrder

+ (NSString *)primaryKey {
  return @"orderId";
}

- (instancetype)initWithJSON:(id)JSONObj {
  self = [super init];
  if (self) {
    id purchase = [JSONObj valueForKey:@"purchase"];
    id program = [purchase valueForKey:@"program"];
    self.orderId = [[JSONObj valueForKey:@"id"] integerValue];
    self.scheduledDay = [[BBCalendarService sharedService] dateForString:[JSONObj valueForKey:@"scheduled_for"]];
    self.address = [[JSONObj valueForKey:@"address"] valueForKey:@"content"];
    self.commentOrder = [JSONObj valueForKey:@"comment"];
    self.nameProgram = [program valueForKey:@"name"];
    NSInteger blockId = [[program valueForKey:@"block_id"] integerValue];
    BBBlock *block = [BBBlock objectsWhere:[NSString stringWithFormat:@"blockId=%ld", (long) blockId]].firstObject;
    [self setColorWithColor:[BBConstantAndColor colorForR:block.red G:block.green B:block.blue alpha:1.0f]];
    self.nameBlock = block.name;
  }
  return self;
}

- (void)setColorWithColor:(UIColor *)color {
  const CGFloat *components = CGColorGetComponents(color.CGColor);
  self.red = components[0];
  self.green = components[1];
  self.blue = components[2];
}

@end
