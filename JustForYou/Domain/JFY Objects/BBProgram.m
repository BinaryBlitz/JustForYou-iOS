

@implementation BBProgram

+ (NSDictionary *)linkingObjectsProperties {
  return @{
      @"days": [RLMPropertyDescriptor descriptorWithClass:BBDay.class propertyName:@"program"],
  };
}

+ (NSString *)primaryKey {
  return @"programId";
}

+ (NSArray *)ignoredProperties {
  return @[@"parentId"];
}

- (instancetype)initWithJSON:(id)JSONObj {
  self = [super init];
  if (self) {
    self.programId = [[JSONObj valueForKey:@"id"] integerValue];
    self.name = [JSONObj valueForKey:@"name"];
    self.descript = [JSONObj valueForKey:@"description"];
    self.shortDescript = [JSONObj valueForKey:@"preview"];
    self.threshold = [[JSONObj valueForKey:@"threshold"] integerValue];
    self.primaryPrice = [[JSONObj valueForKey:@"primary_price"] integerValue];
    self.secondaryPrice = [[JSONObj valueForKey:@"secondary_price"] integerValue];
    self.previewImage = [JSONObj valueForKey:@"image_url"];
    self.unit = [JSONObj valueForKey:@"unit"];
    self.individualPrice = [[JSONObj valueForKey:@"individual_price"] boolValue];
    if (self.previewImage == [NSNull class]) {
      self.previewImage = nil;
    }
    [self _initPrescriptionArrayWithJSON:[JSONObj valueForKey:@"prescription"]];
  }
  return self;
}

- (void)_initPrescriptionArrayWithJSON:(id)JSONArray {
  if (JSONArray && [JSONArray isKindOfClass:[NSArray class]]) {
    if ([JSONArray count] > 0) {
      self.firstPrescription = JSONArray[0];
    }
    if ([JSONArray count] > 1) {
      self.secondPrescription = JSONArray[1];
    }
    if ([JSONArray count] > 2) {
      self.thirdPrescription = JSONArray[2];
    }
  }
}

@end
