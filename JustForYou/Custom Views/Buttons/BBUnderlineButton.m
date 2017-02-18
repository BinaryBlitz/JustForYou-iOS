#import "BBUnderlineButton.h"

static CGFloat indentForLine = 2.0f;
static CGFloat heightForLine = 0.5f;

@implementation BBUnderlineButton

- (void)drawRect:(CGRect)rect {
  CGRect textRect = self.titleLabel.frame;

  CGFloat descender = self.titleLabel.font.descender + indentForLine;

  CGContextRef contextRef = UIGraphicsGetCurrentContext();

  CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);

  CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + indentForLine + textRect.size.height + descender);

  CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + 2 + textRect.size.height + descender);

  CGContextSetLineWidth(contextRef, heightForLine);

  CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
