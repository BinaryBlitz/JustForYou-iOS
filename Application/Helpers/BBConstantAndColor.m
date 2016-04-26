//
//  BBConstantAndColor.m
//  JustForYou
//
//  Created by Антон on 29.03.16.
//  Copyright © 2016 BinaryBlitz. All rights reserved.
//

#import "BBConstantAndColor.h"

@implementation BBConstantAndColor

#pragma mark - Colors

+ (UIColor *)applicationOrangeColorWithAlpha:(CGFloat)alpha {
    return [self colorForR:255.0f G:87.0f B:34.0f alpha:alpha];
}

+ (UIColor *)applicationOrangeColor {
    return [self colorForR:255.0f G:87.0f B:34.0f alpha:1.0f];
}

+ (UIColor *)applicationDarkColor {
    return [self colorForR:46.0f G:58.0f B:64.0f alpha:1.0f];
}

+ (UIColor *)applicationGrayColor {
    return [self colorForR:128.0f G:128.0f B:128.0f alpha:1.0f];
}

+ (UIColor *)colorForR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:alpha];
}


#pragma mark - Constant

+ (kModelIPhone)modelDevice {
    CGFloat heightDevice = [[UIScreen mainScreen] bounds].size.height;
    if (heightDevice == 480) {
        return kModelIPhone4;
    } else if (heightDevice == 568) {
        return kModelIPhone5;
    } else if (heightDevice == 667) {
        return kModelIPhone6;
    } else {
        return kModelIPhone6plus;
    }
}


@end