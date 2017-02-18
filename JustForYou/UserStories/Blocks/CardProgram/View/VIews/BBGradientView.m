#import "BBGradientView.h"

static CGFloat lineWight = 1.f;

@implementation BBGradientView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, lineWight);
    for (int i = 0; i <= CGRectGetHeight(rect); i++) {
        CGContextMoveToPoint(context, 0, i);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), i);
        
        CGFloat alpha = i/CGRectGetHeight(rect);
        UIColor *color = [UIColor colorWithWhite:1 alpha:alpha];
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextStrokePath(context);
    }
}

@end
