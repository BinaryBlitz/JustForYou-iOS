

NSString *const kProgramId = @"jProgramId";
NSString *const kHour = @"jHour";
NSString *const kMinute = @"jMinute";
NSString *const kDaysArray = @"jDaysArray";
NSString *const kScheduledDay = @"jScheduledDay";
NSString *const kCommentOrder = @"jCommentOrder";
NSString *const kNameBlock = @"jNameBlock";
NSString *const kAddress = @"jAddress";
NSString *const kComment = @"jComment";

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
