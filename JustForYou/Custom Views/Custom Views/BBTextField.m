#import "BBTextField.h"

@implementation BBTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
  return CGRectInset(bounds, 10, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  return CGRectInset(bounds, 10, 0);
}

@end
