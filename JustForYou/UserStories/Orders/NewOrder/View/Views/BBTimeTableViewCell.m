

@interface BBTimeTableViewCell ()

@property (nonatomic) NSInteger startHour;
@property (nonatomic) NSInteger startMinute;

@end

static NSInteger maxStartHour = 10;
static NSInteger minStartHour = 5;
static NSInteger stepForHour = 1;
static NSInteger stepForMinute = 30;

static NSString *errorTimeMessage = @"Время доставки может быть только в интервале с 5:00 до 11:00";

@implementation BBTimeTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.startHour = 5;
  self.startMinute = 0;
  self.timeLabel.text = [NSString stringWithFormat:@"5:00 - 6:00"];
}

- (void)setStartHour:(NSInteger)startHour minute:(NSInteger)minute {
  self.startHour = startHour;
  self.startMinute = minute;
  [self updateTimeLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect contentViewFrame = self.contentView.frame;
  contentViewFrame.origin.x = sideOffsetCell;
  contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell * 2;
  self.contentView.frame = contentViewFrame;
}

- (void)drawRect:(CGRect)rect {

  CAShapeLayer *borderLayer = [self _createBorderLayer];
  CAShapeLayer *maskLayer = [CAShapeLayer layer];
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
  maskLayer.path = maskPath.CGPath;
  borderLayer.path = maskPath.CGPath;
  self.contentView.layer.mask = maskLayer;
  [self.contentView.layer addSublayer:borderLayer];
}

- (CAShapeLayer *)_createBorderLayer {
  CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
  borderLayer.frame = self.contentView.bounds;
  borderLayer.lineWidth = borderWightLineCell;
  borderLayer.strokeColor = [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor;
  borderLayer.fillColor = [UIColor clearColor].CGColor;

  return borderLayer;
}

- (IBAction)minusButtonAction:(id)sender {
  if (self.startHour > minStartHour) {
    if (self.startMinute == stepForMinute) {
      self.startMinute = 0;
    } else {
      self.startHour -= stepForHour;
      self.startMinute = stepForMinute;
    }
  } else if (self.startHour == minStartHour && self.startMinute == stepForMinute) {
    self.startMinute = 0;
  } else {
    if ([self.delegate respondsToSelector:@selector(presentAlertForMessage:)]) {
      [self.delegate presentAlertForMessage:errorTimeMessage];
    }
  }
  [self updateTimeLabel];
}

- (IBAction)plusButtonAction:(id)sender {
  if (self.startHour < maxStartHour) {
    if (self.startMinute == stepForMinute) {
      self.startHour += stepForHour;
      self.startMinute = 0;
    } else {
      self.startMinute = stepForMinute;
    }
  } else {
    if ([self.delegate respondsToSelector:@selector(presentAlertForMessage:)]) {
      [self.delegate presentAlertForMessage:errorTimeMessage];
    }
  }
  [self updateTimeLabel];
}

- (void)startHourAndMinute {
  if ([self.delegate respondsToSelector:@selector(startHour:startMinute:)]) {
    [self.delegate startHour:self.startHour startMinute:self.startMinute];
  }
}

- (void)updateTimeLabel {
  if (self.startMinute == 0) {
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:00 - %ld:00", (long) self.startHour, (long) self.startHour + 1];
  } else {
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:30 - %ld:30", (long) self.startHour, (long) self.startHour + 1];
  }
}


@end
