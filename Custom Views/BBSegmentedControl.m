//
//  BBSegmentedControl.m
//  JustForYou
//
//  Created by Антон on 10.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBSegmentedControl.h"


@interface BBSegmentedControl()

@property (nonatomic) CGFloat centerPointForFirstSegment;
@property (nonatomic) CGFloat centerPointForSecondSegment;

@end

static CGFloat wightUnderLine = 41.f;
static CGFloat heightUnderLine = 2.f;

@implementation BBSegmentedControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self _setTestAtributed];
    }
    
    return self;
}

- (void)_setTestAtributed {
    UIFont *systemFont = [UIFont boldSystemFontOfSize:12.0f];
    
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                  systemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [BBConstantAndColor applicationOrangeColor], NSForegroundColorAttributeName,
                                  systemFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.centerPointForFirstSegment = CGRectGetWidth(self.frame)/4;
    self.centerPointForSecondSegment = (CGRectGetWidth(self.frame)/2) + (CGRectGetWidth(self.frame)/4);
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, heightUnderLine);
    CGContextSetStrokeColorWithColor(context, [BBConstantAndColor applicationOrangeColor].CGColor);
    
    if (self.selectedSegmentIndex == BBDescriptionSegmentedIndex) {
        CGContextMoveToPoint(context, self.centerPointForFirstSegment - (wightUnderLine/2), CGRectGetHeight(self.frame) - heightUnderLine);
        CGContextAddLineToPoint(context, self.centerPointForFirstSegment + (wightUnderLine/2), CGRectGetHeight(self.frame) - heightUnderLine);
    } else {
        CGContextMoveToPoint(context, self.centerPointForSecondSegment - (wightUnderLine/2), CGRectGetHeight(self.frame) - heightUnderLine);
        CGContextAddLineToPoint(context, self.centerPointForSecondSegment + (wightUnderLine/2), CGRectGetHeight(self.frame) - heightUnderLine);
    }
    
    CGContextStrokePath(context);
}

@end
