//
//  BBUnderlineButton.m
//  JustForYou
//
//  Created by Антон on 26.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBUnderlineButton.h"

@implementation BBUnderlineButton

- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    
    CGFloat descender = self.titleLabel.font.descender;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y+2 + textRect.size.height + descender);
    
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y+2 + textRect.size.height + descender);
    
    CGContextSetLineWidth(contextRef, 0.5f);
    
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
