

NSString *const kProgramId = @"kProgramId";
NSString *const kHour = @"kHour";
NSString *const kMinute = @"kMinute";
NSString *const kDaysArray = @"kDaysArray";
NSString *const kScheduledDay = @"kScheduledDay";
NSString *const kCommentOrder = @"kCommentOrder";
NSString *const kNameProgram = @"kNameProgram";
NSString *const kNameBlock = @"kNameBlock";
NSString *const kAddress = @"kAddress";
NSString *const kComment = @"kComment";

@implementation BBOrderProgram

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super init];
  if (self) {
    self.programId = [coder decodeIntegerForKey:kProgramId];
    self.hour = [coder decodeIntegerForKey:kHour];
    self.minute = [coder decodeIntegerForKey:kMinute];
    self.days = [coder decodeObjectForKey:kDaysArray];
    self.address = [coder decodeObjectForKey:kAddress];
    self.commentOrder = [coder decodeObjectForKey:kComment];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeInteger:self.programId forKey:kProgramId];
  [aCoder encodeInteger:self.hour forKey:kHour];
  [aCoder encodeInteger:self.minute forKey:kMinute];
  [aCoder encodeObject:self.days forKey:kDaysArray];
  [aCoder encodeObject:self.address forKey:kAddress];
  [aCoder encodeObject:self.commentOrder forKey:kComment];
}

@end
