

@implementation BBForWhomTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)setDescriptions:(NSString *)first :(NSString *)second :(NSString *)third {
  self.first = first;
  self.second = second;
  self.third = third;
  if (!first) {
    first = @"";
  }
  if (!second) {
    second = @"";
  }
  if (!third) {
    third = @"";
  }
  self.descriptLabel.text = [NSString stringWithFormat:@"1. %@\n\n2. %@\n\n3. %@\n", first, second, third];
}

- (void)reloadUIWithProgram:(BBProgram *)program {
  self.program = program;
  if (program.name) {
    self.nameLabel.text = program.name;
  } else {
    self.nameLabel.text = @"";
  }
  self.costLabel.text = [BBConstantAndColor formatedStringForOneDayWithProgram:program];
  self.bigCostLabel.text = [BBConstantAndColor formatedStringForAnyDayWithProgram:program];
}

@end

