

@implementation BBMenuTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.cardView.layer.borderWidth = 1.0f;
  self.cardView.layer.borderColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
  self.cardView.layer.cornerRadius = 6;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect {
}

- (void)setMenuWithMenu:(BBMenu *)menu {
  self.menuLabel.text = [NSString stringWithFormat:@"%@ %ldгр.", menu.content, (long) menu.weight];
  self.caloriesLabel.text = [NSString stringWithFormat:@"%ld Ккал", (long) menu.calories];
  NSString *time = [self _timeWithMenu:menu];
  self.timeLabel.text = time;
  [self setNeedsLayout];
  [self layoutIfNeeded];
}

- (NSString *)_timeWithMenu:(BBMenu *)menu {
  NSString *result = @"";
  NSString *startH;
  NSString *startM;
  NSString *endH;
  NSString *endM;
  if (menu.startsHour >= 0 && menu.startsHour < 10) {
    startH = [NSString stringWithFormat:@"0%ld", (long) menu.startsHour];
  } else {
    startH = [NSString stringWithFormat:@"%ld", (long) menu.startsHour];
  }
  if (menu.startsMinute >= 0 && menu.startsMinute < 10) {
    startM = [NSString stringWithFormat:@"0%ld", (long) menu.startsMinute];
  } else {
    startM = [NSString stringWithFormat:@"%ld", (long) menu.startsMinute];
  }
  if (menu.endsHour >= 0 && menu.endsHour < 10) {
    endH = [NSString stringWithFormat:@"0%ld", (long) menu.endsHour];
  } else {
    endH = [NSString stringWithFormat:@"%ld", (long) menu.endsHour];
  }
  if (menu.endsMinute >= 0 && menu.endsMinute < 10) {
    endM = [NSString stringWithFormat:@"0%ld", (long) menu.endsMinute];
  } else {
    endM = [NSString stringWithFormat:@"%ld", (long) menu.endsMinute];
  }
  result = [NSString stringWithFormat:@"%@:%@-%@:%@", startH, startM, endH, endM];
  return result;
}

@end
