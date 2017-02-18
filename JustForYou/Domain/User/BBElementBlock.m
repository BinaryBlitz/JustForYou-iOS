#import "BBElementBlock.h"

@implementation BBElementBlock

- (instancetype)initWithBlockId:(NSInteger)blockId {
  self = [super init];
  if (self) {
    BBBlock *block = [BBBlock objectsWhere:[NSString stringWithFormat:@"blockId=%ld", (long) blockId]].firstObject;
    self.colorBlock = [BBConstantAndColor colorForR:block.red G:block.green B:block.blue alpha:1.0f];
    self.nameBlock = block.name;
  }
  return self;
}

@end
