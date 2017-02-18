#import "BBSegmentedControl.h"

@interface BBSegmentedControl ()

@property (strong, nonatomic) UIFont *fontForTitle;

@property (nonatomic) CGFloat centerPointForFirstSegment;
@property (nonatomic) CGFloat centerPointForSecondSegment;
@property (nonatomic) CGFloat centerPointForThirdSegment;

@end

static CGFloat heightUnderLine = 2.f;
static CGFloat fontSize = 12.0f;

@implementation BBSegmentedControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];

  if (self) {
    [self _setTestAtributed];
  }

  return self;
}

- (void)_setTestAtributed {
  self.fontForTitle = [UIFont boldSystemFontOfSize:fontSize];

  [self                              setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
      [BBConstantAndColor applicationDarkColor], NSForegroundColorAttributeName,
      self.fontForTitle, NSFontAttributeName, nil] forState:UIControlStateNormal];

  [self                              setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
      [BBConstantAndColor applicationOrangeColor], NSForegroundColorAttributeName,
      self.fontForTitle, NSFontAttributeName, nil] forState:UIControlStateSelected];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.centerPointForFirstSegment = CGRectGetWidth(self.frame) / 6;
  self.centerPointForSecondSegment = (CGRectGetWidth(self.frame) / 2);
  self.centerPointForThirdSegment = CGRectGetWidth(self.frame) - (CGRectGetWidth(self.frame) / 6);
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSetLineWidth(context, heightUnderLine);
  CGContextSetStrokeColorWithColor(context, [BBConstantAndColor applicationOrangeColor].CGColor);

  NSString *title = [self titleForSegmentAtIndex:self.selectedSegmentIndex];

  NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.fontForTitle, NSFontAttributeName, nil];
  CGFloat widhtTitle = [[[NSAttributedString alloc] initWithString:title attributes:attributes] size].width;

  if (self.selectedSegmentIndex == BBForWhomSegmentedIndex) {
    CGContextMoveToPoint(context, self.centerPointForFirstSegment - (widhtTitle / 2), CGRectGetHeight(self.frame) - heightUnderLine);
    CGContextAddLineToPoint(context, self.centerPointForFirstSegment + (widhtTitle / 2), CGRectGetHeight(self.frame) - heightUnderLine);
  } else if (self.selectedSegmentIndex == BBDescriptionSegmentedIndex) {
    CGContextMoveToPoint(context, self.centerPointForSecondSegment - (widhtTitle / 2), CGRectGetHeight(self.frame) - heightUnderLine);
    CGContextAddLineToPoint(context, self.centerPointForSecondSegment + (widhtTitle / 2), CGRectGetHeight(self.frame) - heightUnderLine);
  } else {
    CGContextMoveToPoint(context, self.centerPointForThirdSegment - (widhtTitle / 2), CGRectGetHeight(self.frame) - heightUnderLine);
    CGContextAddLineToPoint(context, self.centerPointForThirdSegment + (widhtTitle / 2), CGRectGetHeight(self.frame) - heightUnderLine);
  }
  CGContextStrokePath(context);
}

@end
