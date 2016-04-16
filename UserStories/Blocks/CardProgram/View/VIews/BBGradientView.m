//
//  BBGradientView.m
//  JustForYou
//
//  Created by Антон on 16.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

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
