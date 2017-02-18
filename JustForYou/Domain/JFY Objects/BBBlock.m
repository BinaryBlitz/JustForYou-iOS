

@implementation BBBlock

+ (NSString *)primaryKey {
  return @"blockId";
}

+ (NSDictionary *)linkingObjectsProperties {
  return @{
      @"programs": [RLMPropertyDescriptor descriptorWithClass:BBProgram.class propertyName:@"block"],
  };
}

- (instancetype)initWithJSON:(id)JSONObj {
  self = [super init];
  if (self) {
    self.blockId = [[JSONObj valueForKey:@"id"] integerValue];
    self.name = [JSONObj valueForKey:@"name"];
    self.image = [JSONObj valueForKey:@"image_url"];
    self.programs_count = [[JSONObj valueForKey:@"programs_count"] integerValue];
    self.red = 0;
    self.green = 0;
    self.blue = 0;
    [self setSelfColorForStringHEX:[JSONObj valueForKey:@"color"]];
  }
  return self;
}

- (void)setSelfColorForStringHEX:(NSString *)hex {
  if (hex) {
    NSString *noHashString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    unsigned hexInt;
    if (![scanner scanHexInt:&hexInt]) {
      return;
    }
    self.red = (hexInt >> 16) & 0xFF;
    self.green = (hexInt >> 8) & 0xFF;
    self.blue = (hexInt) & 0xFF;
  }
}


@end
