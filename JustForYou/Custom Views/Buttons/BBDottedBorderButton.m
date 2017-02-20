

static CGFloat wightLine = 1.0f;
static NSUInteger dashPattern = 5;
static NSUInteger spacePattern = 6;

@implementation BBDottedBorderButton

- (void)layoutSubviews {
  [super layoutSubviews];

  self.cornerRadius = CGRectGetHeight(self.frame) / 2;

  self.borderType = BorderTypeDashed;
  self.borderWidth = wightLine;
  self.dashPattern = dashPattern;
  self.spacePattern = spacePattern;

  self.borderColor = [BBConstantAndColor applicationOrangeColor];
}

- (void)drawDashedBorder {
  if (self.shapeLayer)
    [self.shapeLayer removeFromSuperlayer];

  //border definitions
  CGFloat cornerRadius = self.cornerRadius;
  CGFloat borderWidth = self.borderWidth;
  NSInteger dashPattern1 = self.dashPattern;
  NSInteger dashPattern2 = self.spacePattern;
  UIColor *lineColor = self.borderColor ? self.borderColor : [UIColor blackColor];

  //drawing
  CGRect frame = self.bounds;

  self.shapeLayer = [CAShapeLayer layer];

  //creating a path
  CGMutablePathRef path = CGPathCreateMutable();

  //drawing a border around a view
  CGPathMoveToPoint(path, NULL, 0, frame.size.height - cornerRadius);
  CGPathAddLineToPoint(path, NULL, 0, cornerRadius);
  CGPathAddArc(path, NULL, cornerRadius, cornerRadius, cornerRadius, M_PI, -M_PI_2, NO);
  CGPathAddLineToPoint(path, NULL, frame.size.width - cornerRadius, 0);
  CGPathAddArc(path, NULL, frame.size.width - cornerRadius, cornerRadius, cornerRadius, -M_PI_2, 0, NO);
  CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height - cornerRadius);
  CGPathAddArc(path, NULL, frame.size.width - cornerRadius, frame.size.height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
  CGPathAddLineToPoint(path, NULL, cornerRadius, frame.size.height);
  CGPathAddArc(path, NULL, cornerRadius, frame.size.height - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);

  //path is set as the _shapeLayer object's path
  _shapeLayer.path = path;
  CGPathRelease(path);

  self.shapeLayer.backgroundColor = [[UIColor clearColor] CGColor];
  self.shapeLayer.frame = frame;
  self.shapeLayer.masksToBounds = NO;
//    [self.shapeLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isCircle"];
  self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
  self.shapeLayer.strokeColor = [lineColor CGColor];
  self.shapeLayer.lineWidth = borderWidth;
//    self.shapeLayer.lineDashPattern = _borderType == BorderTypeDashed ? [NSArray arrayWithObjects:[NSNumber numberWithInteger:dashPattern1], [NSNumber numberWithInteger:dashPattern2], nil] : nil;
  self.shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInteger:dashPattern1], [NSNumber numberWithInteger:dashPattern2], nil];
  self.shapeLayer.lineCap = kCALineCapRound;

  //_shapeLayer is added as a sublayer of the view
  [self.layer addSublayer:_shapeLayer];
  self.layer.cornerRadius = cornerRadius;
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];

  if (highlighted) {
    self.borderColor = [BBConstantAndColor applicationOrangeColorWithAlpha:0.2f];
  } else {
    self.borderColor = [BBConstantAndColor applicationOrangeColor];
  }
  [self drawDashedBorder];
}

- (void)drawRect:(CGRect)rect {
  [self drawDashedBorder];
}

@end
