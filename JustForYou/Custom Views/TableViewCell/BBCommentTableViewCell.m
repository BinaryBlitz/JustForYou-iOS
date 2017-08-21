

@implementation BBCommentTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.textView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
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

- (void) setComment:(NSString *)comment {
  [self.textView setText:comment];
  if ([comment isEqualToString:@""]) {
    self.placeholderLabel.hidden = NO;
  } else {
    self.placeholderLabel.hidden = YES;
  }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

  if ([text isEqualToString:@"\n"]) {
    [textView resignFirstResponder];
    return NO;
  } else {
    if (textView.text.length == range.length && [text isEqualToString:@""]) {
      self.placeholderLabel.hidden = NO;
    } else {
      self.placeholderLabel.hidden = YES;
    }
  }
  return YES;
}

@end
