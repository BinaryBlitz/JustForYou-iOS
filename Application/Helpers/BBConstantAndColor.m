//
//  BBConstantAndColor.m
//  JustForYou
//
//  Created by Антон on 29.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBConstantAndColor.h"

@implementation BBConstantAndColor

+ (UIColor *)applicationOrangeColor {
    return [self colorForR:242.0f G:114.0f B:65.0f alpha:1.0f];
}

+ (UIColor *)applicationDarkColor {
    return [self colorForR:46.0f G:58.0f B:64.0f alpha:1.0f];
}


+ (UIColor *)colorForR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r/256.0f green:g/256.0f blue:b/256.0f alpha:alpha];
}

@end