

@interface BBTextTableViewCell () <UITextFieldDelegate>

@end

@implementation BBTextTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.textField.delegate = self;
  self.setRadius = NO;
  self.kSideCornerRadius = kNoneCornerRadius;
  self.kStyleContentCell = kStandartContentCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (NSString *)getTextFromTextField {
  return self.textField.text;
}

- (void)setPlaceholderInTextField:(NSString *)placeholder {
  self.textField.placeholder = placeholder;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (self.kStyleContentCell == kCardContentCell) {
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.x = sideOffsetCell;

    contentViewFrame.size.width = CGRectGetWidth(contentViewFrame) - sideOffsetCell * 2;
    self.contentView.frame = contentViewFrame;
  }
}

#pragma mark - Draw Methods

- (void)drawRect:(CGRect)rect {
  if (self.kStyleContentCell == kCardContentCell) {
    CAShapeLayer *borderLayer = [self _createBorderLayer];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    UIBezierPath *maskPath;

    if (self.setRadius == YES) {
      if (self.kSideCornerRadius == kTopCornerRadius) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
        maskLayer.path = maskPath.CGPath;
      }
      if (self.kSideCornerRadius == kBottomCornerRadius) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
        maskLayer.path = maskPath.CGPath;
      }
      if (self.kSideCornerRadius == kAllCornerRadius) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadiusCell, cornerRadiusCell)];
        maskLayer.path = maskPath.CGPath;
      }
    } else {
      maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeZero];
      maskLayer.path = maskPath.CGPath;
    }

    borderLayer.path = maskPath.CGPath;
    self.contentView.layer.mask = maskLayer;
    [self.contentView.layer addSublayer:borderLayer];
  }
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
