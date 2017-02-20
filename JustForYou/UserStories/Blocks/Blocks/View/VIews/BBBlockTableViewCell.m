

static CGFloat sideOffset = 35.0f;

@implementation BBBlockTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)setCountProgram:(NSInteger)programs {
  self.numberProgramInBlock.text = [NSString stringWithFormat:@"%ld %@", (long) programs, [BBConstantAndColor getNumberEndingWith:programs andEndings:@[@"ПРОГРАММА", @"ПРОГРАММЫ", @"ПРОГРАММ"]]];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect contentViewFrame = self.contentView.frame;
  contentViewFrame.origin.x = sideOffset;
  contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffset * 2;
  contentViewFrame.size.height = CGRectGetHeight(contentViewFrame) - sideOffset;
  self.contentView.frame = contentViewFrame;
}

- (void)drawRect:(CGRect)rect {
  CAShapeLayer *borderLayer = [self _createBorderLayer];
  CAShapeLayer *maskLayer = [CAShapeLayer layer];
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
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


@end
