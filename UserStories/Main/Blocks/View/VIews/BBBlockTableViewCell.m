//
//  BBBlockTableViewCell.m
//  JustForYou
//
//  Created by Антон on 06.04.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBBlockTableViewCell.h"

static CGFloat sideOffset = 27.0f;
static CGFloat lineWight = 1.0f;


@implementation BBBlockTableViewCell


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect newRect = CGRectMake(sideOffset, lineWight, CGRectGetWidth(rect) - (sideOffset*2), CGRectGetHeight(rect) - bottomOffsetForBlockTableView);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, newRect);
    CGContextFillPath(context);
    
    CGContextSetLineWidth(context, lineWight);
    CGContextSetStrokeColorWithColor(context, [BBConstantAndColor colorForR:230 G:230 B:230 alpha:1.0f].CGColor);
    CGContextAddRect(context, newRect);
    CGContextStrokePath(context);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
