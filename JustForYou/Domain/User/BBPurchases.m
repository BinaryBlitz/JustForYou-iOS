#import "BBPurchases.h"

@implementation BBPurchases

- (instancetype)initWithJSON:(id)JSONObj {
  self = [super init];
  if (self) {
    self.purchasesId = [[JSONObj valueForKey:@"id"] integerValue];
    self.numberDays = [[JSONObj valueForKey:@"number_of_days"] integerValue];
    self.deliveriesCount = [[JSONObj valueForKey:@"deliveries_count"] integerValue];
    self.countDays = self.numberDays - self.deliveriesCount;
    [self initProgramOptionsWithPorgram:[JSONObj objectForKey:@"program"]];
  }
  return self;
}

- (void)initProgramOptionsWithPorgram:(id)prog {
  self.programId = [[prog valueForKey:@"id"] integerValue];
  self.primaryPrice = [[prog valueForKey:@"primary_price"] integerValue];
  self.secondaryPrice = [[prog valueForKey:@"secondary_price"] integerValue];
  self.threshold = [[prog valueForKey:@"threshold"] integerValue];
  self.nameProgram = [prog valueForKey:@"name"];
  self.elementBlock = [[BBElementBlock alloc] initWithBlockId:[[prog valueForKey:@"block_id"] integerValue]];
}

@end
